
    ahora          = new Date();
    ahoraDay    = ahora.getDate();
    ahoraMonth = ahora.getMonth();
    ahoraYear   = ahora.getYear();

    /**
 * Nestcape Navigator 4x cuenta el anyo a partir de 1900, por lo que es necesario
 * sumarle esa cantidad para obtener el anyo actual adecuadamente
 **/
       if (ahoraYear < 2000) 
        ahoraYear += 1900;

    /**
 * funcion para saber cuantos dias tiene cada mes
 */
    function cuantosDias(mes, anyo)
    {
        var cuantosDias = 31;
        if (mes == "Abril" || mes == "Junio" || mes == "Septiembre" || mes == "Noviembre")
      cuantosDias = 30;
        if (mes == "Febrero" && (anyo/4) != Math.floor(anyo/4))
      cuantosDias = 28;
        if (mes == "Febrero" && (anyo/4) == Math.floor(anyo/4))
      cuantosDias = 29;
        return cuantosDias;
    }

    /**
 * una vez que sabemos cuantos dias tiene cada mes
 * asignamos dinamicamente este numero al combo de los dias dependiendo 
 * del mes que aparezca en el combo de los meses
 */
    function asignaDias()
    {
        comboDias = document.formFecha.card2_dia;
        comboMeses = document.formFecha.card2_Mes;
        comboAnyos = document.formFecha.card2_anyo;

        Month = comboMeses[comboMeses.selectedIndex].text;
        Year = comboAnyos[comboAnyos.selectedIndex].text;

        diasEnMes = cuantosDias(Month, Year);
        diasAhora = comboDias.length;

        if (diasAhora > diasEnMes)
        {
            for (i=0; i<(diasAhora-diasEnMes); i++)
            {
                comboDias.options[comboDias.options.length - 1] = null
            }
        }
        if (diasEnMes > diasAhora)
        {
            for (i=0; i<(diasEnMes-diasAhora); i++)
            {
                sumaOpcion = new Option(comboDias.options.length + 1);
                comboDias.options[comboDias.options.length]=sumaOpcion;
            }
        }
        if (comboDias.selectedIndex < 0) 
          comboDias.selectedIndex = 0;
     }

    /**
 * ahora selecionamos en los combos los valores correspondientes 
 * a la fecha actual del sistema
 */
    function ponDia()
    {
        comboDias = eval("document.formFecha.card2_dia");
        comboMeses = eval("document.formFecha.card2_Mes");
        comboAnyos = eval("document.formFecha.card2_anyo");

        comboAnyos[0].selected = true;
        comboMeses[ahoraMonth].selected = true;
  
        asignaDias();

        comboDias[ahoraDay-1].selected = true;
    }

    /**
 * esta funcion crea dinamicamente el combo de los anyos, empezando
 * por el actual y acabando por el actual+masAnyos
 */

 
    function rellenaAnyos(masAnyos)
    {
        cadena = "";

        for (i=0; i<masAnyos; i++)
        {
            cadena += "<option>";
            cadena += ahoraYear - i;
        }
        return cadena;
    }
