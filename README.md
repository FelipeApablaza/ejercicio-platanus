Para correr este código se debe tener instalada la gema **text-table** ---> *gem install text-table*.Se utilizan, además, las gemas **faraday** y **json**.

Se debe correr el archivo main.rb con el archivo back.rb en la misma carpeta --->  *ruby main.rb*

Al correr el código se desplegará una lista con los mercados que actualmente opera la api. Luego, basta con ingresar una opción (número) para obtener la transacción de mayor monto en las últimas 24 horas de un mercado. También se puede obtener el mayor monto para todos los mercados de una sola vez. Esta última opción tomará varios segundos en ejecutarse, debido a la cantidad de *requests* requeridas. Una vez que se muestra el resultado de la opción se termina la ejecución del código.

La transacción de mayor monto de cada mercado se obtiene considerando el monto de la *base currency*, es decir, la primera moneda que se muestra en el nombre del mercado. También se consideró calcular un rango de tiempo de 24 horas tomando como referencia el momento en que se ejecuta la opción. Junto al monto también se muestra el nombre del mercado, el precio pagado, el tipo de transacción (compra o venta) y el timestamp de dicha transacción.

**Nota**: tener presente que la api tiene un límite de 120 *requests* por minuto.