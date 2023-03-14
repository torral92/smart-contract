// SPDX-License-Identifier: GPL-3.0

// https://eips.ethereum.org/EIPS/eip-20

pragma solidity^0.8.0;

contract NewToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    constructor() {
        name="MyCin";
        symbol="MC";
        decimals = 18;
        totalSupply = 21000000 * (uint256 (10) ** decimals); // el número de tokens hay que sumarle cero según el número de decimales que le hemos puesto.
        balanceOf[msg.sender] = totalSupply; // Especificamos que todos los tokens son nuestros.  

    }

    mapping (address => uint256) public balanceOf; // Esto llevará toda la relación de las direcciones con sus respectivos saldos.
    // Los mapping pueden anidar otros mapping. 
    mapping (address => mapping(address => uint256)) public allowance; // Mi dirección tiene asociada otra dirección que a su vez tiene una cantidad de token que puede gestionar o transferir.(autorización)

    event Transfer(address indexed _from, address indexed _to,uint256 _value); 
    event Approval(address indexed _from, address indexed _to,uint256 _value); 

    function transfer(address _to,uint256 _value) public returns(bool success) {
        require(balanceOf[msg.sender] >= _value); // El usuario que solicite la transferencia debe cumplir el requisito de que debe ser mayor o igual a la cantidad de tokens.
        balanceOf[msg.sender] -= _value; // Ahora realizaremos una compensacion de balance
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value); // especificamos que se le envíe al usuario que ejecuta la función, desde la dirección del contrato y una cantidad específica.
        return true;
    }

    // Usuario al que se le autoriza, y la cantidad de token. En el que no tenemos transacción por lo que no hay que realizar filtros de calidad por ahora. 
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value; //Con esto hemos asignado en el array la persona autorizada y el token. Msg.sender es el dueño del contrato, el usuario que desea la autorización y el value los tokens.
        emit Approval(msg.sender, _spender, _value); 
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value); // Comprobacion que el dueño tiene esos tokens realmente.
        require(allowance[_from][msg.sender] >= _value); // Comprobar que el usuario tiene autorización para manejar esos tokens.
        balanceOf[_from] -= _value;// Ahora realizamos de nuevo la compensación de balance.
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value; // Hay que modificar el value del usuario para modificar los token que tiene derecho a utilizar. 
        emit Transfer(_from, _to, _value); 
        return true;

    }



}

// Este contrato es complilable sin errores. 
