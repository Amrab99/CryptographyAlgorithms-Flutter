class Logic {
  // Caesar Cipher encryption and decryption
  String caesar(String text, int key, int encrypt) {
    String result = "";
    //amr   
    for (var i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i), offset, x;

      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0))
        offset = 97;
      else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0))
        offset = 65;
      else if (ch == ' '.codeUnitAt(0)) {
        result += " ";
        continue;
      }

      if (encrypt == 1)
        x = (ch + key - offset) % 26; //b  98 + 4 + - 97 = 5   
      else
        x = (ch - key - offset) % 26;

      result += String.fromCharCode(x + offset);
    }
    return result;
  }

// Vigenere Cipher encryption and decryption
  String vigenere(String text, String key, int encrypt) {
    String result = '';
    int j = 0;
    for (var i = 0; i < text.length; i++) {
      if (encrypt == 1) {
        int x = (text.codeUnitAt(i) + key.codeUnitAt(j)) % 26 + 65;
        result += String.fromCharCode(x);
      } else {
        int y = ((text.codeUnitAt(i) - key.codeUnitAt(j)) % 26 + 26) % 26;
        result += String.fromCharCode(y + 65);
      }
      if (j < key.length - 1)
        j++;
      else
        j = 0;
    }
    return result;
  }

// Playfair cipher encryption & decryption

  String playfairEncrypt(String text, String key) {
    String table = '', result = '';
    text = text.replaceAll(' ', '');
    text = text.replaceAll('j', 'i');
    key = key.replaceAll(' ', '');
    text = text.toLowerCase();
    key = key.toLowerCase();

    for (var i = 0; i < text.length - 1; i++) {
      if (text[i] == text[i + 1])
        text =
            text.substring(0, i + 1) + 'x' + text.substring(i + 1, text.length);
    }
    if (text.length % 2 != 0) text += 'x';

    var matrix = List.generate(5, (i) => List(5)), index = 0;

    for (var i = 0; i < key.length; i++) {
      if (table.contains(key[i]) == false) {
        if (key[i] != 'j') table += key[i];
      }
    }

    for (var i = 'a'.codeUnitAt(0); i <= 'z'.codeUnitAt(0); i++) {
      if (table.contains(String.fromCharCode(i)) == false &&
          String.fromCharCode(i) != 'j') table += String.fromCharCode(i);
    }

    for (var i = 0; i < 5; i++)
      for (var j = 0; j < 5; j++) matrix[i][j] = table[index++];

    for (var i = 0; i < text.length; i += 2) {
      int row1, row2, col1, col2;
      for (var j = 0; j < 5; j++) {
        if (matrix[j].contains(text[i]) == true) {
          row1 = j;
          col1 = matrix[j].indexOf(text[i]);
        }
        if (matrix[j].contains(text[i + 1]) == true) {
          row2 = j;
          col2 = matrix[j].indexOf(text[i + 1]);
        }
      }
      if (row1 == row2) {
        result += matrix[row1][(col1 + 1) % 5];
        result += matrix[row2][(col2 + 1) % 5];
      } else if (col1 == col2) {
        result += matrix[(row1 + 1) % 5][col1];
        result += matrix[(row2 + 1) % 5][col2];
      } else {
        result += matrix[row1][col2];
        result += matrix[row2][col1];
      }
    }
    return result;
  }

  String playfairDecrypt(String text, String key) {
  String table='', result='';
  text = text.replaceAll(' ','');
  key = key.replaceAll(' ','');
  text = text.toLowerCase();
  key = key.toLowerCase();
  
 var matrix = List.generate(5, (i) => List(5)), index = 0;
  
  for(var i=0;i<key.length;i++){
    if(table.contains(key[i]) == false){
     if(key[i] != 'j') 
       table += key[i];
    }
  }
  
  for(var i='a'.codeUnitAt(0); i<='z'.codeUnitAt(0); i++){
    if(table.contains(String.fromCharCode(i)) == false &&       String.fromCharCode(i) != 'j'){
      table += String.fromCharCode(i);
    }
  }
  
  for(var i=0;i<5;i++){
    for(var j=0;j<5;j++){
      matrix[i][j] = table[index++];
    }
  }
    
  for(var i=0;i<text.length;i+=2){
   int row1, row2, col1, col2;
    for(var j=0;j<5;j++){
     if(matrix[j].contains(text[i]) == true){
       row1=j;
       col1=matrix[j].indexOf(text[i]); 
     }
     if(matrix[j].contains(text[i+1]) == true){
       row2=j;
       col2=matrix[j].indexOf(text[i+1]);  
     }
   }
   if(row1 == row2) {
     result += matrix[row1][(col1 - 1)%5];
     result += matrix[row2][(col2 - 1)%5];
   }
   else if(col1 == col2){
     result += matrix[(row1 - 1)%5][col1];
     result += matrix[(row2 - 1)%5][col2];
   }
   else{
     result += matrix[row1][col2];
     result += matrix[row2][col1];
   }
  }
    return result;
  }




}

