# CLI Usage Examples

## Project creation examples

### E-commerce project

```bash
create-nextjs-php-app online-store
cd online-store
# Database configuration: online_store
# WSL2 optimization: Yes
```

### Blog API

```bash
create-nextjs-php-app blog-api
cd blog-api
# Database configuration: blog_api
# WSL2 optimization: No (if on Linux/Mac)
```

### Management application

```bash
create-nextjs-php-app inventory-management
cd inventory-management
# Database configuration: inventory_management
# WSL2 optimization: Yes
```

## Customization after creation

### 1. Database configuration

Edit `backend/.env`:

```env
DB_HOST=db
DB_NAME=my_database
DB_USER=my_user
DB_PASS=my_password
JWT_SECRET=my-very-long-secret-key
```

### 2. Adding a new controller

Create `backend/controller/ControllerProduct.php`:

```php
<?php
class ControllerProduct {
    public function getAll() {
        $model = new ModelProduct();
        return $model->getAllProducts();
    }

    public function create($data) {
        $model = new ModelProduct();
        return $model->createProduct($data);
    }
}
?>
```

### 3. Adding a model

Create `backend/model/ModelProduct.php`:

```php
<?php
class ModelProduct {
    private $db;

    public function __construct() {
        $this->db = new ClassDatabase();
    }

    public function getAllProducts() {
        $query = "SELECT * FROM products";
        return $this->db->query($query);
    }

    public function createProduct($data) {
        $query = "INSERT INTO products (name, price, description) VALUES (?, ?, ?)";
        return $this->db->query($query, [$data['name'], $data['price'], $data['description']]);
    }
}
?>
```

### 4. Adding a frontend route

Create `frontend/src/app/products/page.tsx`:

```tsx
"use client";
import { useState, useEffect } from "react";

interface Product {
    id: number;
    name: string;
    price: number;
    description: string;
}

export default function ProductsPage() {
    const [products, setProducts] = useState<Product[]>([]);

    useEffect(() => {
        fetch("http://localhost:8000/api/products")
            .then((res) => res.json())
            .then((data) => setProducts(data));
    }, []);

    return (
        <div className="container mx-auto p-6">
            <h1 className="text-3xl font-bold mb-6">Products</h1>
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                {products.map((product) => (
                    <div key={product.id} className="border rounded-lg p-4">
                        <h2 className="text-xl font-semibold">{product.name}</h2>
                        <p className="text-green-600 font-bold">${product.price}</p>
                        <p className="text-gray-600">{product.description}</p>
                    </div>
                ))}
            </div>
        </div>
    );
}
```

### 5. Modifying the database schema

Edit `db/flepourtous.sql`:

```sql
-- Add a products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO products (name, price, description) VALUES
('Laptop', 999.99, 'High-performance laptop'),
('Gaming Mouse', 79.99, 'RGB gaming mouse'),
('Mechanical Keyboard', 149.99, 'Cherry MX Blue switches');
```

## Recommended development workflow

### 1. Daily startup

```bash
cd my-project
make dev          # Start all services
make logs         # Monitor logs if needed
```

### 2. Backend development

```bash
# Modify a controller/model
make logs-backend  # View PHP logs
make shell-backend # Access container for debugging
```

### 3. Frontend development

```bash
# Modify a React component
# Hot reload is automatic
make logs-frontend # View Next.js logs if error
```

### 4. Database modification

```bash
# Edit db/flepourtous.sql
make down         # Stop services
make clean        # Clean volumes
make dev          # Restart (recreates DB)
```

### 5. End of day

```bash
make down         # Stop all services
```

## Deployment

### Production preparation

```bash
# Create production version of frontend Dockerfile
# Modify environment variables
# Configure production database
```

### Production build

```bash
# Frontend
cd frontend
npm run build

# Backend
# No compilation needed for PHP
```

## Tips and best practices

### Security

-   Change `JWT_SECRET` in production
-   Use strong passwords for DB
-   Validate all user inputs
-   Implement rate limiting

### Performance

-   Optimize SQL queries
-   Use backend caching
-   Compress frontend assets
-   Implement pagination for large lists

### Code organization

-   One controller per resource (User, Product, Order...)
-   One model per database table
-   Group React components by functionality
-   Use TypeScript for strict typing
