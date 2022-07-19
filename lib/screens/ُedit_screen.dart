import 'package:provider/provider.dart';
import 'package:ver2/providers/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/components.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  static const String routname = '/edit-profile';

  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  var nameController = TextEditingController();
  var emailControllerNew = TextEditingController();
  var phoneControllerNew = TextEditingController();
  var addressControllerNew = TextEditingController();
  var email, phone, address, name;
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<UserAuth>(context);

    emailControllerNew.text = authUser.email;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'تعديل البيانات',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: authUser.fetchUser(
          authUser.id,
          authUser.authToken,
        ),
        builder: (context, snapshot) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                //position label
                margin: EdgeInsetsDirectional.only(),
                padding: EdgeInsets.fromLTRB(260, 0, 0, 0),
                child: Text(
                  'الأسم',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.white, //just to cover the intercepted border
              ),
              defaultFormField(
                  initial: authUser.name,
                  type: TextInputType.name,
                  width: 320,
                  height: 45,
                  onChange: (value) {
                    name = value;
                  }),
              SizedBox(
                height: 15,
              ),
              Container(
                //position label
                margin: EdgeInsetsDirectional.only(),
                padding: EdgeInsets.fromLTRB(210, 0, 0, 0),
                // input outline default seems using 4.0 as padding from their source
                child: Text(
                  'رقم الهاتف ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //just to cover the intercepted border
              ),
              defaultFormField(
                initial: authUser.phoneNumber,
                
                type: TextInputType.visiblePassword,
                width: 320,
                height: 45,
                onChange: (value){
                  phone=value;
                }
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                //position label
                margin: EdgeInsetsDirectional.only(),
                padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                child: Text(
                  'العنوان',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //just to cover the intercepted border
              ),
              defaultFormField(
                initial: authUser.address,
                onChange: (value){
                  address=value;
                },
                type: TextInputType.visiblePassword,
                width: 320,
                height: 45,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                //position label
                margin: EdgeInsetsDirectional.only(),
                padding: EdgeInsets.fromLTRB(160, 0, 0, 0),
                child: Text(
                  'البريد الألكتروني',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //just to cover the intercepted border
              ),
              defaultFormFields(
                controller: emailControllerNew,
                type: TextInputType.visiblePassword,
                width: 320,
                height: 45,
              ),
              SizedBox(
                height: 105,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: defaultButton(
                  radius: 15,
                  function: () async {
                    print("yes");
                    try {
                      await authUser.updateUser(
                          UserAuth(
                            myPoints: authUser.myPoints,
                            id: authUser.id,
                            email: authUser.email,
                            phoneNumber: phone,
                            address: address,
                            name: name,
                          ),
                          authUser.authToken);
                      Fluttertoast.showToast(msg: "تم حفظ التغيرات");
                    } catch (e) {
                      print("no");
                    }
                  },
                  text: 'حفظ التغييرات',
                  height: 80,
                  background: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget defaultFormFields({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  bool isPassword = false,
  Function validate,
  String label,
  IconData prefix,
  IconData suffix,
  Function suffixPressed,
  double width = 280,
  double height = 45,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        validator: validate,
        keyboardType: type,
        obscureText: isPassword,
        enabled: false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
