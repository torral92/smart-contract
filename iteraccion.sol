// SPDX-License-Identifier: GPL-3.0

pragma solidity^0.8.0;


// Patron de diseño de muchisima utilidad. 

contract IteracionLista {

    mapping(address => address) public users;
    //  Establecer un contador que vaya guardando el número de elementos que vayamos agregando a nuestra lista.
    uint256 public listSize; // Tamaño del mapping.
    address constant public FIRST_ADDRESS = address(1); // Debemos inicializar el elemento, retornando una dirección de todos los ceros excepto el último que es un 1.
    
    
    // Con esto inicializamos el mapeo. 
    constructor() {
        users[FIRST_ADDRESS] = FIRST_ADDRESS; // Estamos insertando el primer elemento y debe apuntarse a sí mismo. EL valor es la clave también.
    }

    // Establece si el address está o no en la lista.

    function isInList( address _address) view internal returns(bool) {
        return users[_address] != address(0); //Toda direccion no añadida obtiene este valor, que es todo ceros.
    }


    function getPrevUser(address _address) view internal returns(address) {
        address currentAdress = FIRST_ADDRESS;
        // Cuando esta condicion no se cumple es que estariamos en el ultimo elemento que es a su vez el primero. 
        while(users[currentAdress] != FIRST_ADDRESS) {
            if(users[currentAdress] == _address){
                return currentAdress;
            }
            currentAdress = users[currentAdress];
        }
        return FIRST_ADDRESS;
    }

    function getAllUsers() view public returns(address[] memory) {
        address[] memory usersArray = new address[](listSize);
        address currentAdress = users[FIRST_ADDRESS];
        for(uint256 i = 0 ; currentAdress != FIRST_ADDRESS; i++) {
            usersArray[i] = currentAdress;
            currentAdress = users[currentAdress];

        }
        return usersArray;
    }

    function removeUser(address _address) public {
        require(isInList(_address));
        address prevUser = getPrevUser(_address);
        users[prevUser] = users[_address];
        users[_address] = address(0);
        listSize--;
    }
    // Añadir nuevo usuario.

    function addUser( address _address) public {
        require(isInList(_address));
        users[_address] = users[FIRST_ADDRESS]; // Esta nueva clave tiene que tener como valor, el valor del elemento anterior. 
        users[FIRST_ADDRESS] = _address; // Con este paso hemos cambiado el valor del primero para que apunte al último elemento creado. Para que el siguiente se enlace con el último elemento. OJO. El orden de esto es muy importante ya que sino no obtendremos el resultado deseado.
        listSize++;
    }

    // retornar la direccion que queremos eliminar.


}
