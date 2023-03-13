// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Coches {
    address owner;
    uint256 precio;
    uint256[] identificadores; // Creamos un array de números enteros positivos.

    mapping (address => Coche) coches;
    // datos que recogera cada coche que introduzcamos en la blockchain a traves del smart contract. 
    struct Coche {
        uint256 identificador; // identificador del vehiculo
        string marca; // MArca del vehiculo
        uint32 caballos; //POtencia del vehiculo
        uint32 kilometros; // Kilometraje del vehículo.
    }
    // añadir requerimiento para que el precio de la oferta sea igual al de la demanda. 
    modifier precioFiltro(uint256 _precio) {
        require(_precio == precio);
        _;
    }
    // Inicializamos para obtener el owner y un precio para el coche. 
    constructor(uint256 _precio) {
        owner = msg.sender;
        precio = _precio;
    }
    // Para añadir un coche, debemos tener una función payable, con el modifier precioFiltro para que el valor sea correcto, además de todos los demás valores de un coche para identificarlo.
    function addCoche(uint256 _id,string memory _marca, uint32 _caballos, uint32 _kilometros) external precioFiltro(msg.value) payable {
        identificadores.push(_id); // vamos a guardar el identificador en nuestro array de identificadores. Asi tendremo los coches que tendremos en el smart.
        coches[msg.sender].identificador= _id; // Mapeamos para dar valor al struc.
        coches[msg.sender].marca= _marca;
        coches[msg.sender].caballos= _caballos;
        coches[msg.sender].kilometros= _kilometros;
    }
    //Función que no consume gas, nos dice cuantos coches tenemos registrados en nuestro smart contract. 
    function getIdentificadores() external view returns(uint256) {
        return identificadores.length;

    }
    // Función para ver los coches que tienen una dirección.
    function getCoche() external view returns(string memory marca,uint32 caballos,uint32 kilometros) {
        marca = coches[msg.sender].marca;
        caballos = coches[msg.sender].caballos;
        kilometros = coches[msg.sender].kilometros;
    }

}

// Este código es compilable y sin errores.
