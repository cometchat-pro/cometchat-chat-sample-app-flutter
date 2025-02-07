import 'package:flutter/material.dart';

Future<String?> getInput(BuildContext context) async {
  String text = "";

  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Enter Text",
              labelText: "Enter text",
            ),
            onChanged: (String val) {
              text = val;
            },
          )
        ],
      ),
      actions: [
        TextButton(
            child: const Text("no", style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.pop(context);
            }),
        TextButton(
            child: const Text("yes!", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.pop(context, text);
            })
      ],
    ),
  );
}

Future<String?> getUrl(
    BuildContext context, List<String> urlList, Widget title) async {
  // String text = "";

  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title,
      content: SizedBox(
        // Specify some width
        width: MediaQuery.of(context).size.width * .7,
        child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: urlList.map((String url) {
              return GridTile(
                  child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(url);
                },
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: 12.0,
                  height: 12.0,
                  errorBuilder: (context, error, stackTrace) {
                     return const Icon(Icons.image_not_supported); // Show fallback image
                  }
                ),
              ));
            }).toList()),
      ),
    ),
  );
}

getCard(String url) {
  return Image.network(url, errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.image_not_supported); // Show fallback image
  });
}
