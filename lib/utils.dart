List<int> fibonacci(int maxNumber) {
  int numAnterior = 1;
  int numActual = 1;
  int numFibonacci = 0;
  List<int> response = [];
  for (int i = 0; i <= maxNumber; i++) {
    if (i != 0 && i != 1) {
      numFibonacci = numAnterior + numActual;
      numAnterior = numActual;
      numActual = numFibonacci;
    } else {
      numFibonacci = numActual;
    }
    if (maxNumber >= numFibonacci) {
      response.add(numFibonacci);
    } else {
      break;
    }
  }
  return response;
}

bool isPaindrome(String text) {
  text = text
      .toUpperCase()
      .replaceAll(" ", "")
      .replaceAll("Á", "A")
      .replaceAll("É", "E")
      .replaceAll("Í", "I");
  List text_revertido = text.split('');
  String aux_text_revertido = text_revertido.reversed.join();
  if (text != aux_text_revertido) {
    return false;
  }
  return true;
}

List<int> burbleShort(List<int> list) {
  int n = list.length;
  if (n == 0) {
    return [];
  }

  for (var recorrido = 0; recorrido < n -1; recorrido++) {
    for (var i = 0; i < n - recorrido - 1; i++) {
     if (list[i] > list[i+1]) {
       int cambio = list[i];
       list[i] = list[i+1];
       list[i+1] = cambio;
     }
    } 
  }
  return list;
}

List<int> quickSort(List<int> list) {
  return list;
}
