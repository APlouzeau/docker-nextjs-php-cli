<?php

class ControllerAuth
{
    private $userNotConnected = [
        'code' => 0,
        'message' => 'Utilisateur non connecté'
    ];

    public function verifyConnectBack()
    {
        if (isset($_SESSION['idUser']) && !empty($_SESSION['idUser'])) {
            return true;
        } else {
            http_response_code(401);
            $response = $this->userNotConnected;
            echo json_encode($response);
            exit();
        }
    }

    public function verifyConnect()
    {
        if (isset($_SESSION['idUser']) && !empty($_SESSION['idUser'])) {
            $response = [
                'code' => 1,
                'message' => 'Utilisateur connecté',
                'data' => [
                    'idUser' => $_SESSION['idUser'],
                    'nickName' => $_SESSION['nickName'] ?? null,
                    'role' => $_SESSION['role'] ?? 'user',
                    'mail' => $_SESSION['mail'] ?? null,
                    'firstName' => $_SESSION['firstName'] ?? null,
                    'lastName' => $_SESSION['lastName'] ?? null
                ]
            ];
        } else {
            $response = $this->userNotConnected;
        }
        echo json_encode($response);
    }

    public function login()
    {
        $requestBody = file_get_contents('php://input');
        $data = json_decode($requestBody, true);

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $mail = $data['mail'] ?? '';
            $password = $data['password'] ?? '';

            if (empty($mail) || empty($password)) {
                $response = [
                    'code' => 0,
                    'message' => 'Email et mot de passe requis.'
                ];
            } else {
                $userModel = new ModelUser();
                $userVerify = $userModel->login($mail, $password);

                if ($userVerify === null) {
                    $response = [
                        'code' => 0,
                        'message' => 'Email ou mot de passe incorrect.'
                    ];
                } elseif (isset($userVerify['isVerified']) && $userVerify['isVerified'] === false) {
                    $response = [
                        'code' => 0,
                        'message' => 'Compte non vérifié. Veuillez vérifier votre adresse e-mail.'
                    ];
                } else {
                    // Connexion réussie
                    $_SESSION['idUser'] = $userVerify['idUser'];
                    $_SESSION['nickName'] = $userVerify['nickName'];
                    $_SESSION['role'] = $userVerify['role'];
                    $_SESSION['mail'] = $userVerify['mail'];
                    $_SESSION['firstName'] = $userVerify['firstName'];
                    $_SESSION['lastName'] = $userVerify['lastName'];

                    $response = [
                        'code' => 1,
                        'message' => 'Connexion réussie.',
                        'data' => $_SESSION
                    ];
                }
            }
        } else {
            $response = [
                'code' => 0,
                'message' => 'Méthode non autorisée'
            ];
        }

        echo json_encode($response);
    }

    public function register()
    {
        $requestBody = file_get_contents('php://input');
        $data = json_decode($requestBody, true);

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $firstName = $data['firstName'] ?? '';
            $lastName = $data['lastName'] ?? '';
            $mail = $data['mail'] ?? '';
            $nickName = $data['nickName'] ?? '';
            $password = $data['password'] ?? '';

            if (empty($firstName) || empty($lastName) || empty($mail) || empty($nickName) || empty($password)) {
                $response = [
                    'code' => 0,
                    'message' => 'Tous les champs sont requis.'
                ];
            } else {
                $userModel = new ModelUser();

                // Vérifier si l'email existe déjà
                if ($userModel->checkMail($mail)) {
                    $response = [
                        'code' => 0,
                        'message' => 'Cette adresse email est déjà utilisée.'
                    ];
                } else {
                    // Créer l'utilisateur
                    $userData = [
                        'firstName' => $firstName,
                        'lastName' => $lastName,
                        'mail' => $mail,
                        'nickName' => $nickName,
                        'password' => password_hash($password, PASSWORD_DEFAULT),
                        'verifyToken' => bin2hex(random_bytes(32)),
                        'role' => 'user',
                        'isVerified' => 0
                    ];

                    $user = new EntitieUser($userData);

                    if ($userModel->register($user)) {
                        $response = [
                            'code' => 1,
                            'message' => 'Inscription réussie. Veuillez vérifier votre email.'
                        ];
                    } else {
                        $response = [
                            'code' => 0,
                            'message' => 'Erreur lors de l\'inscription.'
                        ];
                    }
                }
            }
        } else {
            $response = [
                'code' => 0,
                'message' => 'Méthode non autorisée'
            ];
        }

        echo json_encode($response);
    }

    public function logout()
    {
        session_unset();
        session_destroy();
        setcookie(session_name(), "", time() - 3600, "/");

        echo json_encode([
            'code' => 1,
            'message' => 'Déconnexion réussie.'
        ]);
    }

    public function verify()
    {
        $token = $_GET['token'] ?? '';

        if (empty($token)) {
            $response = [
                'code' => 0,
                'message' => 'Token de vérification manquant.'
            ];
        } else {
            $userModel = new ModelUser();

            if ($userModel->verifyEmail($token)) {
                $response = [
                    'code' => 1,
                    'message' => 'Email vérifié avec succès.'
                ];
            } else {
                $response = [
                    'code' => 0,
                    'message' => 'Token de vérification invalide.'
                ];
            }
        }

        echo json_encode($response);
    }
}
