
// import '../Controller/link_controller.dart';
// import 'widgets/google_button_widget.dart';

// class AddingLink extends StatefulWidget {
//   static const id = '/AddingLink';

//   const AddingLink({super.key});

//   @override
//   State<AddingLink> createState() => _AddingLinkState();
// }

// class _AddingLinkState extends State<AddingLink> {
//   TextEditingController titleController = TextEditingController();

//   TextEditingController linkController = TextEditingController();
//   TextEditingController usernameController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   void addmyLink() {
//     if (_formKey.currentState!.validate()) {
//       final body = {
//         'title': titleController.text,
//         'link': linkController.text,
//         'username': usernameController.text
//       };
//       addLink(context, body).then((user) async {}).catchError((err) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(err.toString()),
//           backgroundColor: Colors.red,
//         ));
//       });
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32.0),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height -
//                 AppBar().preferredSize.height,
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const Spacer(),
//                   SizedBox(
//                       height: MediaQuery.of(context).size.height / 8,
//                       child: Hero(
//                           tag: 'authImage',
//                           child: SvgPicture.asset(AssetsData.authImage))),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   Text(
//                     'Adding Link',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 44,
//                   ),
//                   CustomTextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) return 'This Feild is required';
//                     },
//                     controller: titleController,
//                     hint: 'Link title',
//                     label: 'Title',
//                   ),
//                   const SizedBox(
//                     height: 14,
//                   ),
//                   CustomTextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) return 'This Feild is required';
//                     },
//                     controller: linkController,
//                     hint: 'Link',
//                     label: 'Link',
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   CustomTextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) return 'This Feild is required';
//                     },
//                     controller: usernameController,
//                     hint: 'user name',
//                     label: 'User name',
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   SecondaryButtonWidget(
//                       onTap: () {
//                         addmyLink();
//                       },
//                       text: 'ADD LINK'),
//                   const SizedBox(
//                     height: 80,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:betweenerapp/views/widgets/custom_text_form_field.dart';
import 'package:betweenerapp/views/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../Controller/link_controller.dart';
import '../Model/link.dart';
import '../assets.dart';

class AddEditLink extends StatefulWidget {
  static const id = '/AddEditLink';

  final Link? link; // Optional link to edit, null for adding

  const AddEditLink({Key? key, this.link}) : super(key: key);

  @override
  _AddEditLinkState createState() => _AddEditLinkState();
}

class _AddEditLinkState extends State<AddEditLink> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.link != null;

  @override
  void initState() {
    if (isEditing) {
      titleController.text = widget.link!.title!;
      linkController.text = widget.link!.link!;
      usernameController.text = widget.link!.username!;
    }
    super.initState();
  }

  void saveLink() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': titleController.text,
        'link': linkController.text,
        'username': usernameController.text,
        'isActive': '0'
      };

      if (isEditing) {
        editLink(context, widget.link!.id!, body).then((isupdated) {
        });
      } else {
        addLink(context, body).then((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Link added successfully!'),
              backgroundColor: Colors.green,
            ));
          }
        }).catchError((err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(err.toString()),
            backgroundColor: Colors.red,
          ));
        });
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Hero(
                          tag: 'authImage',
                          child: SvgPicture.asset(AssetsData.authImage))),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    isEditing ? 'Edit Link' : 'Add Link',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 44,
                  ), // ... Your existing code ...

                  CustomTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return 'This Field is required';
                    },
                    controller: titleController,
                    hint: 'Link title',
                    label: 'Title',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return 'This Field is required';
                    },
                    controller: linkController,
                    hint: 'Link',
                    label: 'Link',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return 'This Field is required';
                    },
                    controller: usernameController,
                    hint: 'user name',
                    label: 'User name',
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  SecondaryButtonWidget(
                    onTap: () {
                      saveLink();
                    },
                    text: isEditing ? 'SAVE' : 'ADD LINK',
                  ),

                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
