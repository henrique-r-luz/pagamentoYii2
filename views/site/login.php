<?php

use yii\widgets\ActiveForm;



?>
<!-- Outer Row -->
<div class="row justify-content-center">

    <div class="col-xl-6 col-lg-6 col-md-6">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <?php $form = ActiveForm::begin(['id' => 'login']); ?>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Seja Bem Vindo!</h1>
                            </div>

                            <div class="form-group">
                                <input type="text" name="LoginForm[username]" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Login">
                            </div>
                            <div class="form-group">
                                <input type="password" name="LoginForm[password]" class="form-control form-control-user" id="exampleInputPassword" placeholder="Senha">
                            </div>
                            <button class="btn btn-primary btn-user btn-block" type="submit" name="login-button">Login</button>


                            <!-- <hr>
                             <div class="text-center">
                                <a class="small" href="forgot-password.html">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="register.html">Create an Account!</a>
                            </div> -->
                        </div>
                    </div>
                </div>
                <?php ActiveForm::end(); ?>
            </div>
        </div>

    </div>

</div>