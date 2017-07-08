<a class="menutoggle"><i class="fa fa-bars"></i></a>

<div class="header-right">
  <ul class="headermenu">
    <li class = "active">
      <?php 
        if ($content  == "mantenimiento") {
          echo '<a type="button" href = "'.$maindir.'pages/mantenimiento.php" class="btn btn-default dropdown-toggle active" >
          <span class = "fa fa-cog"></span>
              Mantenimiento del sistema
          </a>';
        }
        else{
          echo '<a type="button" href = "'.$maindir.'pages/mantenimiento.php" class="btn btn-default dropdown-toggle " >
          <span class = "fa fa-cog"></span>
              Mantenimiento del sistema
          </a>';
        }
       ?>
      
    </li>
    <li>
      <div class="btn-group">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
          <span class = "fa fa-user"></span>
          <?php echo $usuario; ?>
          <span class="caret"></span>
        </button>
        <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
          <?php 
            echo '<li><a href="'.$maindir.'login/checkout.php"><i class="glyphicon glyphicon-log-out"></i>Salir</a></li>'; 
          ?>
        </ul>
      </div>
    </li>
  </ul>
</div><!-- header-right -->