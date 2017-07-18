

<div class="logopanel">
        <h1><span>[</span> WorkFlow Financiero SOLINVER <span>]</span></h1>
    </div><!-- logopanel -->
        
    <div class="leftpanelinner">    
        
        <!-- This is only visible to small devices -->
        <div class="visible-xs hidden-sm hidden-md hidden-lg">   
            <div class="media userlogged">
                <?php 
                  // echo "<img alt='' src='".$maindir."img/loggeduser.png' class='media-object'>" 
                ?>
                
                <div class="media-body">
                    <h4>Usuario</h4>
                </div>
            </div>
          
            <ul class="nav nav-pills nav-stacked nav-bracket mb30">
              <li><a href="../login/checkout.php"><i class="fa fa-sign-out"></i> <span>Salir</span></a></li>
            </ul>
        </div>
      
      <h5 class="sidebartitle">Módulos</h5>
      <ul class="nav nav-pills nav-stacked nav-bracket">
        <?php 
          if($content == "home"){
            echo '<li class="active"><a href="'.$maindir.'pages/home.php"><i class="fa fa-home"></i> <span>Inicio</span></a></li>';
          }
          else{
            echo '<li class=""><a href="'.$maindir.'pages/home.php"><i class="fa fa-home"></i> <span>Inicio</span></a></li>';
          }

          if($content == "solicitudes"){
            echo '<li class = "active"><a href="'.$maindir.'/pages/solicitudes/solicitudes.php"><i class="fa fa-list-alt"></i> <span>Solicitudes</span></a></li>';
          }
          else{
            echo '<li><a href="'.$maindir.'pages/solicitudes/solicitudes.php"><i class="fa fa-list-alt"></i> <span>Solicitudes</span></a></li>';
          }

          if($content == "rrhh"){
            echo ' <li class = "active"><a href="'.$maindir.'/pages/rrhh.php"><i class="fa fa-group"></i> <span>Analista RRHH</span></a></li>';
          }
          else{
            echo ' <li><a href="'.$maindir.'pages/rrhh.php"><i class="fa fa-group"></i> <span>Analista RRHH</span></a></li>';
          }

          if($content == "creditos"){
            echo '<li class = "active"><a href="'.$maindir.'/pages/creditos.php"><i class="fa fa-bank"></i> <span>Analista Créditos</span></a></li>';
          }
          else{
            echo ' <li><a href="'.$maindir.'pages/creditos.php"><i class="fa fa-bank"></i> <span>Analista Créditos</span></a></li>';
          }

          if($content == "aprobaciones"){
            echo '<li class = "active" ><a href="'.$maindir.'pages/aprobaciones/aprobaciones.php"><i class="fa fa-gavel"></i> <span>Aprobaciones</span></a></li>';
          }
          else{
            echo ' <li><a href="'.$maindir.'pages/aprobaciones/aprobaciones.php"><i class="fa fa-gavel"></i> <span>Aprobaciones</span></a></li>';
          }

         ?>
        
       <!--  <li class="nav-parent"><a href="#"><i class="fa fa-edit"></i> <span>Analista RRHH</span></a>
          <ul class="children">
            <li><a href="#"><i class="fa fa-caret-right"></i> modulo 1.1</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> modulo 1.2</a></li>
          </ul>
        </li> -->
      </ul>
      
      
    </div><!-- leftpanelinner -->