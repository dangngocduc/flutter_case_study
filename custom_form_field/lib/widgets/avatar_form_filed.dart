import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:image_picker/image_picker.dart';

class AvatarFormFiled extends FormField<File> {
  AvatarFormFiled({
    Key key,
    FormFieldValidator<File> validator,
    FormFieldSetter<File> onSaved,
    File initialValue,
    bool autoValidate = true,
    bool enabled = true
  }): super(
    key: key,
    validator: validator,
    onSaved: onSaved,
    initialValue: initialValue,
    autovalidate: autoValidate,
    builder: (FormFieldState<File> state) {
      Widget content = Container(
        width: 200,
        child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: Container(
                alignment: Alignment.bottomCenter,
                color: state.value == null ? Colors.grey : null,
                decoration: state.value != null ? BoxDecoration(
                    image: DecorationImage(image: FileImage(state.value), fit: BoxFit.cover)
                ) : null,
                child: Container(
                  color: Colors.black38,
                  height: 48,
                  width: double.infinity,
                  child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white,),
                      onPressed: () async {
                        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                        state.didChange(image);
                      }),
                ),
              ),
            )
        ),
      );
      if (state.hasError) {
        return Column(
          children: <Widget>[
            content,
            Padding(
              padding: EdgeInsets.only(top: 48),
              child: Text(state.errorText, style: Theme.of(state.context).textTheme.body1.copyWith(
                color: Colors.red
              ),),
            )
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            content,
            Padding(
              padding: EdgeInsets.only(top: 48),
              child: FlatButton(
                onPressed: (){
                  state.didChange(null);
                },
                child: Text('Remove Avatar'),
              ),
            )
          ],
        );
      }
    }
  );

}
