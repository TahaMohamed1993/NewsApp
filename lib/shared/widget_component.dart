import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../modules/web_view_flutter/web_viewscreen.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigatorTo(
            context,
            WebViewScreen(
              url: article['url'],
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),

                // image: DecorationImage(

                // image: NetworkImage(

                //   '${article['urlToImage']}',

                // ),

                //   fit: BoxFit.cover,

                // ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${article['publishedAt']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget atriclBuilder(List list) {
  return InkWell(
    child: ConditionalBuilder(
        condition: list.length > 0,
        builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildArticleItem(
                  list[index],
                  context,
                ),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: list.length),
        fallback: (context) =>
            const Center(child: CircularProgressIndicator())),
  );
}

Widget dufaltFormField(
        {required TextInputType? keyboardType,
        void Function(String)? onChanged,
        bool obscureText = false,
        required String? Function(String?)? validat,
        Widget? label,
        void Function()? onTap,
        required String? hintText,
        required Widget? icon,
        TextEditingController? controller,
        Widget? prefixIcon}) =>
    TextFormField(
      onTap: onTap,
      obscureText: obscureText,
      controller: controller,
      validator: validat,
      decoration: InputDecoration(
        suffixIcon: prefixIcon,
        icon: icon,
        label: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
      ),
    );
navigatorTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
