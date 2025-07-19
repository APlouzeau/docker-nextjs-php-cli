#!/bin/bash

# Update script for create-nextjs-php-app CLI
# This script helps manage versions and releases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}🚀 create-nextjs-php-app Update Manager${NC}"
    echo "============================================"
    echo
}

check_git_status() {
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${RED}❌ Git working directory is not clean${NC}"
        echo "Please commit or stash your changes before releasing"
        exit 1
    fi
}

get_current_version() {
    node -p "require('./package.json').version"
}

update_version() {
    local version_type=$1
    echo -e "${YELLOW}📝 Updating version (${version_type})...${NC}"
    npm version $version_type --no-git-tag-version
    local new_version=$(get_current_version)
    echo -e "${GREEN}✅ Version updated to ${new_version}${NC}"
    echo $new_version
}

update_changelog() {
    local version=$1
    local date=$(date +%Y-%m-%d)
    
    echo -e "${YELLOW}📝 Updating CHANGELOG.md...${NC}"
    
    # Replace [Unreleased] with [version] - date
    sed -i "s/## \[Unreleased\]/## [${version}] - ${date}/" CHANGELOG.md
    
    # Add new [Unreleased] section
    sed -i "/## \[${version}\] - ${date}/i ## [Unreleased]\n\n### Added\n\n### Changed\n\n### Fixed\n" CHANGELOG.md
    
    echo -e "${GREEN}✅ CHANGELOG.md updated${NC}"
}

build_and_test() {
    echo -e "${YELLOW}🔧 Testing CLI...${NC}"
    
    # Clean any existing test projects first
    rm -rf test-* *-test cli-test-* my-*-project demo-* example-* temp-* 2>/dev/null || true
    
    # Test CLI help and version commands (non-interactive)
    node bin/create-app.js --help >/dev/null 2>&1 || {
        echo -e "${RED}❌ CLI help command failed${NC}"
        exit 1
    }
    
    node bin/create-app.js --version >/dev/null 2>&1 || {
        echo -e "${RED}❌ CLI version command failed${NC}"
        exit 1
    }
    
    node bin/create-app.js check-updates >/dev/null 2>&1 || {
        echo -e "${RED}❌ CLI update check failed${NC}"
        exit 1
    }
    
    # Test that required files exist
    if [ ! -f "bin/create-app.js" ]; then
        echo -e "${RED}❌ CLI binary not found${NC}"
        exit 1
    fi
    
    if [ ! -d "templates" ]; then
        echo -e "${RED}❌ Templates directory not found${NC}"
        exit 1
    fi
    
    # Clean any test artifacts
    rm -rf *.tgz 2>/dev/null || true
    rm -rf /tmp/cli-test-* 2>/dev/null || true
    
    echo -e "${GREEN}✅ CLI test passed${NC}"
}

publish_npm() {
    echo -e "${YELLOW}📦 Publishing to npm...${NC}"
    
    # Clean old builds
    rm -f *.tgz
    
    # Dry run first
    npm pack --dry-run >/dev/null
    
    # Publish
    npm publish
    
    echo -e "${GREEN}✅ Published to npm${NC}"
}

git_commit_and_tag() {
    local version=$1
    
    echo -e "${YELLOW}📝 Creating git commit and tag...${NC}"
    
    git add package.json CHANGELOG.md
    git commit -m "chore: release v${version}"
    git tag "v${version}"
    
    echo -e "${GREEN}✅ Git commit and tag created${NC}"
}

push_to_github() {
    echo -e "${YELLOW}🔄 Pushing to GitHub...${NC}"
    
    git push origin main
    git push origin --tags
    
    echo -e "${GREEN}✅ Pushed to GitHub${NC}"
}

# Main script
print_header

case "${1:-}" in
    "patch"|"minor"|"major")
        echo -e "${BLUE}🚀 Starting release process for ${1} version...${NC}"
        echo
        
        check_git_status
        
        current_version=$(get_current_version)
        echo -e "Current version: ${current_version}"
        
        new_version=$(update_version $1)
        update_changelog $new_version
        build_and_test
        
        echo
        echo -e "${YELLOW}Ready to publish version ${new_version}?${NC}"
        read -p "Continue? [y/N] " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git_commit_and_tag $new_version
            publish_npm
            push_to_github
            
            echo
            echo -e "${GREEN}🎉 Release ${new_version} completed successfully!${NC}"
            echo -e "📦 Published to npm: https://www.npmjs.com/package/create-nextjs-php-app"
            echo -e "🏷️  GitHub release: https://github.com/APlouzeau/docker-nextjs-php-cli/releases/tag/v${new_version}"
        else
            echo -e "${YELLOW}Release cancelled${NC}"
            # Revert version change
            git checkout package.json CHANGELOG.md
        fi
        ;;
    "check")
        echo -e "${BLUE}📋 Checking current status...${NC}"
        echo
        echo -e "Current version: $(get_current_version)"
        echo -e "Git status: $(git status --porcelain | wc -l) uncommitted changes"
        echo -e "Latest npm version: $(npm view create-nextjs-php-app version 2>/dev/null || echo 'not found')"
        ;;
    "test")
        echo -e "${BLUE}🧪 Testing CLI...${NC}"
        build_and_test
        ;;
    "clean")
        echo -e "${BLUE}🧹 Cleaning up test projects and artifacts...${NC}"
        
        # Clean test projects
        test_projects=$(ls -d test-* *-test cli-test-* my-*-project demo-* example-* temp-* 2>/dev/null || true)
        if [ -n "$test_projects" ]; then
            echo -e "${YELLOW}Removing test projects: $test_projects${NC}"
            rm -rf $test_projects
        fi
        
        # Clean build artifacts
        if ls *.tgz 1> /dev/null 2>&1; then
            echo -e "${YELLOW}Removing *.tgz files${NC}"
            rm -f *.tgz
        fi
        
        # Clean temp directories
        temp_dirs=$(ls -d /tmp/cli-test-* 2>/dev/null || true)
        if [ -n "$temp_dirs" ]; then
            echo -e "${YELLOW}Removing temp directories: $temp_dirs${NC}"
            rm -rf $temp_dirs
        fi
        
        echo -e "${GREEN}✅ Cleanup completed${NC}"
        ;;
    *)
        echo "Usage: $0 [patch|minor|major|check|test|clean]"
        echo
        echo "Commands:"
        echo "  patch  - Release a patch version (bug fixes)"
        echo "  minor  - Release a minor version (new features)"
        echo "  major  - Release a major version (breaking changes)"
        echo "  check  - Check current status"
        echo "  test   - Test CLI functionality"
        echo "  clean  - Clean up test projects and build artifacts"
        echo
        echo "Examples:"
        echo "  $0 patch   # 1.0.0 -> 1.0.1"
        echo "  $0 minor   # 1.0.0 -> 1.1.0"
        echo "  $0 major   # 1.0.0 -> 2.0.0"
        echo "  $0 clean   # Remove test-*, *.tgz files"
        exit 1
        ;;
esac
