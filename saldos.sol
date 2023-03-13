// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Banco {

    //Almacenar o gestionar direcciones.
    address owner;


    modifier onlyOwner {
        require(msg.sender == owner);
        _; // Si no ponemos esto no se ejecutara nada en la funcion que uses el modifier.
    }



    // Permite que esta función pueda ser pagable con payable. 
    constructor () payable {
        // variable de estado global que puede ser utilizada en cualquier momento, en el cual el que deploy el contrato se considera el owner. 
        owner = msg.sender;

   }
    function newOwner(address _newOwner) public onlyOwner {
        owner = _newOwner; // Si el creador del smart contract desea dar el control a otra persona con esto tenemos la opcion de modificar el owner del contrato. 

    }
    function getOwner() view public returns(address) {
        return owner; //Función que nos diga la dirección del owner actual.
    }

    function getBalance() view public returns(uint256) {
        return address(this).balance;
    }
    // Como queremos meter dinero, necesitamos que sea payable. 
    function incremetBalance(uint256 amount) payable public {
        require(msg.value == amount); // Importante especificar la cantidad y asegurarnos que el usuario manda la cantidad que el quiere. 
                                    // Buena práctica, por ejemplo para venta de entradas, si se equivocan en el precio que no ejecute y no paguen tanto de más como de menos.     
    }

    // No necesitamos meter dinero con esta funcion ya que es para ver el balance.
    function withdrawBalance() public onlyOwner {
        // COn onlyOwner limitamos que solo pueda usarlo el owner del contrato, así nadie puede llamarlo y reclamar el balance para el. 
        payable(msg.sender).transfer (address(this).balance);// Usar transfer para indicar el destino y cantidad a transferir, en este caso con this hace referencia al objeto invocado.Concretamente la dirección de este contrato. 
                                                             // con esto el que llama a esta funcion, se le transfiera todo el balance del contrato. 
    }

    


}
