// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract Loteria {
    address internal owner; //
    uint256 internal num; //
    uint256 public numGanador; //
    uint256 public precio; //
    bool public juego; //
    address public ganador; //

    // Generar un numero hardcoreado como variable de estado en el smart contract del 1 al 9, ejecutando la función
    // se genera un número aleatorio si coincide se dará la mitad del premio a el y la otra mitad al dueño del contrato
    // sino el premio se acumula.
    constructor(uint256 _numeroGanador, uint256 _precio) payable {
        owner =msg.sender; // Dueño en este caso nosotros
        num = 0; // variable num a cero
        numGanador = _numeroGanador; // Numero ganador
        precio = _precio; // Precio del ticket
        juego = true; // Forma de dar de baja el juego, requerimiento de true para poder participar.
    }

    function comprobarAcierto(uint256 _num) private view returns(bool) {
        if(_num == numGanador) {
            return true;
            } else {
                return false;
            }
        }

    
    //Genera seudo-aleatoriedad, pero cuidado no es una aleatoriedad real. Si necesitas algo así es recomendable ver las funciones de los oraculos para inyectar variables aleatorias.
    function numeroRandom() private view returns(uint256) {
        return uint256( keccak256( abi.encode(block.timestamp, msg.sender, num ) ) ) %10; 
    }

    // 
    function participar() external payable returns(bool resultado,uint256 numero) {
        require(juego==true);
        require(msg.value==precio);
        uint256 numUsuario = numeroRandom();
        bool acierto = comprobarAcierto(numUsuario);
        if (acierto == true) {
            juego = false;
            payable(msg.sender).transfer(address(this).balance/2);
            ganador = msg.sender;
            resultado = true;
            numero = numUsuario;
        
        } else {
            num++;
            resultado = false;
            numero = numUsuario;
        }
    }

    function verPremio() public view returns(uint256) {
        return address(this).balance - (num * (precio/2));
    }

    function retirarFondosContrato() external returns(uint256) {
        require(msg.sender == owner); //Nadie mas pueda ejecutarlo.
        require(juego == false); // No queremos que podamos retirar los fondos antes de que tengamos un ganador. 
        payable(msg.sender).transfer(address(this).balance); // Se envia la mitad del premio acumlado. 
        return address(this).balance; // a modo info nos dice el premio repartido. 

    }
}

// Este contrato es complilable si errores.
