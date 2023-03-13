// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contador {
    
    uint256 count; // Creacion de variable de estado de un smart contract.
    
    // Inicializador de Deploy, esta función es ejecutada sólo una vez al inicio del deploy, inicializando el valor
    // de la variable count. 
    constructor(uint256 _count) {
        count=_count; 

    }

    // Cambiamos el valor de count, es pública para que tanto el contrato como desde el exterior pueda llamarse a la función.

    function setCount(uint256 _count) public {
        count=_count;
    }

    //Incrementamos en 1 cada vez que se llama a la función.
    function incremetCount() public {
        count +=1; //Incremento en 1 el valor de la variable. 
    }

    // Llamamos al count para visualizar su valor, con view puede llamar para ver pero no para modificar.
    // No consume gasa. 
    function getCount() public view returns(uint256) {
        return count;
    }

    // Con pure, ni va a escribir ni leer ninguna de las variables del contrato. Es más restrictivo que view.
    // No consume gas.
    function getNumber() public pure returns(uint256) {
        return 34;

    }
}

// Este código es compilable y sin errores.
