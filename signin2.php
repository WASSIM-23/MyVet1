<?php

    require_once "../configuration/connexion.php";
    session_start();
    $error=0;
if(isset($_POST['register']))
{

    if(isset($_POST['nom']) && !empty($_POST['nom']))
    {
      $nom = mysqli_real_escape_string($conn,ucwords($_POST['nom']));
      
      $allow = "/^[a-zA-Z]+(\s[a-zA-Z]+)?$/";
      if(!preg_match($allow,$nom))
      {
        $error=1;
        $e_nom="Veuillez entrer le nom correct!";
        
      }else if(strlen($nom) > 25)
      {
         $error=1;
         $e_nom="Le nom ne peut pas dépasser les 25 caractéres!";
         
      
      }
      
    } else{
      $error=1;
      $e_nom="Obligatoire! ";
      
    }


    if(isset($_POST['prenom']) && !empty($_POST['prenom']))
    {
      $prenom = mysqli_real_escape_string($conn,ucwords($_POST['prenom']));
      
      $allow = "/^[a-zA-Z]+(\s[a-zA-Z]+)?$/";
      if(!preg_match($allow,$prenom))
      {
          $error=1;
          $e_prenom="Veuillez entrer le prenom correct!";
          
      }else if(strlen($prenom) > 25)
      {
          $error=1;
          $e_prenom="Le prenom ne peut pas dépasser les 25 caractéres!";
         
      
      }
      
    } else{
      $error=1;
      $e_prenom="Obligatoire! ";
    }

    if(isset($_POST['type']) && !empty($_POST['type']))
    {
            $type=mysqli_real_escape_string($conn,$_POST["type"]);  

            if(!in_array($type,['Vétérinaire généraliste','Vétérinaire spécialiste']))
            {
                $error=1;
             
            }

    }else{
             $error=1;
             $e_type="Obligatoire! ";
        }



        if(isset($_POST['specialite']) && !empty($_POST['specialite']))
        {
            $specialite= mysqli_real_escape_string($conn,$_POST["specialite"]) ;

            if(!in_array($specialite,['Chirurgie des petits animaux','Médecine des tissus mous','Médecine dentaire vétérinaire','Médecine des grands animaux','Maladies infectieuses']))
            {
                $error=1;
             
            }

        }else{
            $specialite= "/";
        }

    if(isset($_POST['email']) && !empty($_POST['email']))
    {
      
      $email =mysqli_real_escape_string($conn,$_POST['email']);
      
          $stmt = $conn->prepare("SELECT `email` FROM `veterinaire` WHERE `email` = ? LIMIT 1");
          $stmt->bind_param("s", $email);
          $stmt->execute();
          $stmt->store_result();
  
          if($stmt->num_rows > 0)
          {
               $error=1;
               $e_email='Cet e-mail est déjà utilisé!';
  
          }
      
      $stmt->close();
    }else
    {
       $error=1;
       $e_email="obligatoire!";
    }

  
        if(isset($_POST['address']) && !empty($_POST['address']))
        {
            $address = mysqli_real_escape_string($conn,$_POST['address']);
        }else
        {
        $error=1;
        $e_address="obligatoire!";
        }
        


    if(isset($_POST['password']) && !empty($_POST['password']))
    {


        $password =mysqli_real_escape_string($conn,$_POST['password']);
        

        if(strpos($password, ' ') !== false)
          {
            $error=1;
            $e_password="le Mot de passe ne doit pas contenir des espaces!";


          }elseif(strlen($password) < 8)
         {
             $error=1;
             $e_password="Le mot de passe doit contenir au moins 8 caractères!";
         }else
         {
            $passwd=password_hash($password, PASSWORD_DEFAULT);
         }

    }else
    {
       $error=1;
        $e_password="Obligatoire!";
    }



    
    if(isset($_POST['telephone']) && !empty($_POST['telephone']))
    {
      $nbr="/^[0]{1}+[5-6-7]{1}+[\d]{8}$/";
      $tel= mysqli_real_escape_string($conn, $_POST['telephone']);

       if(!preg_match($nbr,$tel))
       {
          $error=1;
          $e_telephone="Numero de télephone invalide !";
       }else
       {
        $stmt_phone = $conn->prepare("SELECT `telephone` FROM `veterinaire` WHERE `telephone` = ? LIMIT 1");
        $stmt_phone->bind_param("s", $tel);
        $stmt_phone->execute();
        $stmt_phone->store_result();

        if($stmt_phone->num_rows > 0)
        {
             $error=1;
             $e_telephone='Cet Numéro est déjà utilisé!';

        }
       }
       $stmt_phone->close();

    }else
    {
       $error=1;
       $e_telephone="Obligatoires!";

    }



    if($error==0)
    {
        //insertion en base de données
        $date=date("Y-m-d H:i:s");
        $insertion=mysqli_query($conn,"INSERT INTO `veterinaire`(`nom`, `prenom`, `email`, `password`, `telephone`, `address`, `type`, `specialite`, `date`) VALUES
         ('$nom','$prenom','$email','$passwd','$tel','$address','$type','$specialite','$date')");


        if($insertion)
        {
            $_SESSION['succes']="Compte créé avec succès";
            header('location:login_vet.php');
            die;

        }

       
         

    }



}

?>


<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page d'inscription</title>
    <link rel="stylesheet" href="signin2.css"> 
</head>



<body>

    <div class="container" style="width:700px;">

        <form id="registrationForm" method="POST">
            <h1>Inscription Vétérinaire</h1>
            <div class="form-group">

                <input type="text" id="lastName" name="nom" required aria-required="true"><label for="lastName">Nom:</label>
                <p style="color:red;"><?php if(isset($e_nom)) echo $e_nom;?></p>
            </div>
            <div class="form-group">

                <input type="text" id="firstName" name="prenom" required aria-required="true"><label for="firstName">Prénom:</label>
                <p style="color:red;"><?php if(isset($e_prenom)) echo $e_prenom;?></p>

            </div>
            <div class="form-group">

                <input type="email" id="email" name="email" required aria-required="true"><label for="email">Email:</label>
                <p style="color:red;"><?php if(isset($e_email)) echo $e_email;?></p>

            </div>
            <div class="form-group">

                <input type="text" id="address" name="address" required aria-required="true"><label for="address">Adresse:</label>
                <p style="color:red;"><?php if(isset($e_address)) echo $e_address;?></p>

            </div>
            <div class="form-group">

                <select class="select" id="mainSelect" name="type" id="" onchange="showSpecializations()">
                    <option value="" selected disabled> Type </option>
                    <option value="Vétérinaire généraliste">Vétérinaire généraliste</option>
                    <option value="Vétérinaire spécialiste">Vétérinaire spécialiste</option>
                </select>
                <p style="color:red;"><?php if(isset($e_specialiter)) echo $e_specialiter;?></p>

            </div>
            <div class="form-group">

                <select class="select" id="specializationSelect" name="specialite" style="display: none;">
                    <option value="" selected disabled> Spécialité </option>
                    <option value="Chirurgie des petits animaux">Chirurgie des petits animaux</option>
                    <option value="Médecine des tissus mous">Médecine des tissus mous</option>
                    <option value="Médecine dentaire vétérinaire">Médecine dentaire vétérinaire</option>
                    <option value="Médecine des grands animaux">Médecine des grands animaux</option>
                    <option value="Maladies infectieuses">Maladies infectieuses</option>

                </select>
                <p style="color:red;"><?php if(isset($e_specialiter)) echo $e_specialiter;?></p>

            </div>
            <div class="form-group">

                <input type="password" id="password" name="password" required aria-required="true"><label for="password">Mot de passe:</label>
                <p style="color:red;"><?php if(isset($e_password)) echo $e_password;?></p>

            </div>
            <div class="form-group">

                <input type="tel" id="phoneNumber" name="telephone" required aria-required="true"><label for="phoneNumber">Numéro de téléphone:</label>
                <p style="color:red;"><?php if(isset($e_telephone)) echo $e_telephone;?></p>

            </div>
            <button type="submit" name="register">S'inscrire</button>
            <div class="create-account">
            <p>Vous avez déja un compte? <a href="login_vet.php">Connectez Vous</a></p>
        </div>
        </form>
    </div>


    <script>
        function showSpecializations() {
            var mainSelect = document.getElementById("mainSelect");
            var specializationSelect = document.getElementById("specializationSelect");

            if (mainSelect.value == "Vétérinaire spécialiste") {
                specializationSelect.style.display = "block";
            } else {
                specializationSelect.style.display = "none";
            }
        }
    </script>

</body>

</html>
