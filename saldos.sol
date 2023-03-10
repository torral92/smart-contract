pragma solidity ^0.8.0;

contract Banco {

    // Permite que esta función pueda ser pagable con payable. 
    constructor () payable public {

   }

    // Como queremos meter dinero, necesitamos que sea payable. 
    function incremetBalance(uint256 amount) payable public {
        require(msg.value == amount); // Importante especificar la cantidad y asegurarnos que el usuario manda la cantidad que el quiere. 
                                    // Buena práctica, por ejemplo para venta de entradas, si se equivocan en el precio que no ejecute y no paguen tanto de más como de menos.     
    }

    // No necesitamos meter dinero con esta funcion ya que es para ver el balance.
    function getBalance() public {
        payable(msg.sender).transfer (address(this).balance);// Usar transfer para indicar el destino y cantidad a transferir, en este caso con this hace referencia al objeto invocado.Concretamente la dirección de este contrato. 
                                                             // con esto el que llama a esta funcion, se le transfiera todo el balance del contrato. 
    }


}

// Función que recibe primero Eth y luego da a traves del metodo transfer. 
