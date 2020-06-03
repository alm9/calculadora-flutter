/** possui algumas funcionalidades, como interpretar o botão clicado, operações matemáticas e mostrar os dados no display*/
class Memory {
static const operations = const ['/', 'x', '-', '+', '='];
  /* Estados da calculadora:
  E1 - inicial, digitando value1 (=dígitos) [operando -> E2] [E1 <-- 'AC' em qualquer momento]
  E2 - digitou operando [dígito -> E3]
  E3 - digitando value2 (=dígitos) [operando -> E2] ['=' -> E4] 
  E4 - exibe resultado [dígito -> E1] [operando -> sem exibir result E2]  ['=' -> E4]
  */
  
  int _estado = 1;
  String _typing = '0';
  double _value1 = 0;
  double _value2 = 0;
  String _lastCommand = 'AC';
  bool _wipeValue = false;

  void applyCommand(String command) {
    print('estado: ' + _estado.toString() + ' command: '+command);
    if (command=='AC'){
      _allClear();
      _estado = 1;
      _lastCommand = 'AC';
      return;
    }
    if (command=='⌫'){
      _typing = _typing.substring(0, _typing.length - 1);
      if (_estado == 3)
        _value2 = double.parse(_typing);
      else _value1 = double.parse(_typing);
      return;
    }
    if(operations.contains(command)){
      _setOperation(command);
      return;
    }
    //se chegar aqui, é dígito
    _addDigit(command);
  }

//_wipeValue é true quando acabou de digitar uma operação
//  se ele for true e vier um dígito, atualiza o _typing
  _addDigit(String digit){
    final wipeValue = (_typing == '0' && digit!='.') || _wipeValue;
    final currentValue = wipeValue ? '' : _typing; //limpar tela?
    _typing = currentValue + digit;
    _wipeValue = false;

    if (digit=='.'){
      if (_estado==2){
        _typing = '0.';
        _value2 = 0.0;
        return;
      }
      if (_estado==4){
        _typing = '0.';
        _value1 = 0.0;
        _estado = 1;
        return;
      }
      if (_typing.contains('.')) return;
      if (_estado==1){
        _typing += '.';
        _value1 = 0.0;
        return;
      }
        _typing += '.';
        _value2 = 0.0;
      return;
    }

    switch (_estado) {
      case 1:
        _value1 = double.tryParse(_typing) ?? 0;
        break;
      case 2:
        _estado = 3;
        _value2 = double.tryParse(_typing) ?? 0;
        break;
      case 3:
        _value2 = double.tryParse(_typing) ?? 0;
        break;
      case 4:
        _estado = 1;
        _typing = digit;
        _value1 = double.tryParse(_typing) ?? 0;
        break;
      default: print('Dígito inválido');
    }

    // if (estado == 1 || estado == 4){
    //   
    //   estado = 1;
    // }else{
    //   _value2 = double.tryParse(_typing) ?? 0;
    //   if (estado == 2)
    //     estado = 3;
    // }
  }

  void _doOperation(String operation, double number1, double number2){
    double result;
    // print('doOp >> ' +number1.toString()+' '+operation+' '+number2.toString() +'<--estado:'+_estado.toString());
    switch (operation) {
        case '+':
       result = number1 + number2;
          break;
        case '-':
       result = number1 - number2;
          break;
        case '/':
       result = number1 / number2;
          break;
        case 'x':
       result = number1 * number2;
          break;
        //case '%':
       //result = number1 % number2;
           //break;
        // case '=':
        //   break;
        default: print('Operação inválida');
      }
      // if (estado == 3){ //se digitou '=' nao vai entrar aqui
      //   _value1 = result;
      //   _typing = result.toString();
      //   estado = 2;
      // }
      //
      _value1 = result;
      if (result == 0.0)
      {
        _typing = '0';
        return;
      }
      String resultado = result.toString();
      print('resultado.substring(resultado.length) = '+resultado.substring(resultado.length-1));
      if (resultado.substring(resultado.length-1) == '0')
        resultado = resultado.substring(0, resultado.length-2);
      _typing = resultado;
      //return result;
  }

  _setOperation(String whichOperation){
    switch (_estado) {
      case 1:
      case 2:
        if (whichOperation!='='){
          _estado = 2;
    }
        break;
      case 3:
        _doOperation(_lastCommand, _value1, _value2);
        if (whichOperation=='='){
          _estado = 4;
        } else _estado = 2;
        break;
      case 4:
        if (whichOperation=='='){
          _doOperation(_lastCommand, _value1, _value2);
          _estado = 4;
        } else _estado = 2;
        break;
      default:
    }

    if (whichOperation != '=')
      _lastCommand = whichOperation;
      
    _wipeValue = true;
  }

  _allClear(){
    _typing = '0';
  }

  String get value {
    return _typing;
  }
}