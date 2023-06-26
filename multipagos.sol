//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;


contract MultipleWhihdraw {
    address private owner;

    modifier isOwner() {
        require(msg.sender == owner,"Solo el owner esta autorizado");
        _;
    }
    constructor () {
      owner=msg.sender;
    }
    // 1 Parametro (addresses):Payable para poder manejar saldos y decir que es un array. Al ser un array debemos ponerlo en memoria.
    // 2 parametro( amounts): Neesitamos tener el mismo lend de ambos arrays para que cada direccion tenga una unica cantidad de pago.
    function multipleWhitdraw(address payable[] memory addresses,uint256[] memory amounts) public payable isOwner {
        require(addresses.length == amounts.length, " La longitud de los dos arrays debe ser igual");

        uint256 totalAmount = 0;

        for(uint256 i=0; i < amounts.length;i++) {
            totalAmount += amounts[i] * 1 wei; // Establecemos la unidad del valor, tratando como wei.Que es la unidad minima. 
        }// Al finalizar el bucle for vamos a tener todo el saldo a repartir entre los beneficiarios.

        //ahora vamos a comprar el totalAmount con el valor de nuestra transaccion(cantidad de wei aduntada a la transaccion. 
        require(totalAmount == msg.value,"El valor no coincide.");

        //Vamos a relaizar explicitamente el pago en si.

        for(uint256 i=0; i<addresses.length;i++) {
            uint256 receiverAmount = amounts[i] * 1 wei; // Estamos guardando los wei que vamos a distribuir para cada dirrecion

            addresses[i].transfer(receiverAmount);
        }
    } 
}
// Llamando a esta funicon podemos traferir a diferentes personas diferentes saldos.
//Tenemos un limite teórico por bloque, desbordamiento de pila. 
// Sin fallos de copilacion.
