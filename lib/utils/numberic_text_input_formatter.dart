


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class NumbericTextInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

      if(newValue.text.isEmpty){
        return newValue.copyWith(text: "");
      }    
      else if(newValue.text.compareTo(oldValue.text) != 0){
        // return 0;
        final  int selectIndexFromRight=newValue.text.length - newValue.selection.end;
        final f=NumberFormat("#,###");

        final number=int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));

        final newString=f.format(number);

        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(offset: newString.length - selectIndexFromRight)
        );
      }else{
        return newValue;
      }
  }
  
}