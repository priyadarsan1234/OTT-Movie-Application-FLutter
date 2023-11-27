import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(left: 12, right: 12, top: 12),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.account_box_rounded,
                  size: 70,
                ),
                Text(
                  "Priyadarsan Pradhan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Icon(Icons.edit),
                Icon(Icons.payment_outlined)
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                      title: Text(
                        "My Account",
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text("Manage Your Account "),
                      leading: Icon(Icons.manage_accounts_rounded),
                      trailing: Icon(Icons.arrow_circle_right_sharp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                      title: Text(
                        "My Watchlist",
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text("Show Your Watch History"),
                      leading: Icon(Icons.watch_later),
                      trailing: Icon(Icons.arrow_circle_right_sharp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                      title: Text(
                        "Saved",
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text("Show Saved Videos"),
                      leading: Icon(Icons.save),
                      trailing: Icon(Icons.arrow_circle_right_sharp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                      title: Text(
                        "Video Setting",
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text("Change Your Video Setting "),
                      leading: Icon(Icons.video_call),
                      trailing: Icon(Icons.arrow_circle_right_sharp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                      title: Text(
                        "About Us",
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text("Know More About Us"),
                      leading: Icon(Icons.account_box_outlined),
                      trailing: Icon(Icons.arrow_circle_right_sharp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                      title: Text(
                        "App Language",
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text("Change Language"),
                      leading: Icon(Icons.language),
                      trailing: Icon(Icons.arrow_circle_right_sharp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left:18,right: 18,top: 20,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.share),
                  Icon(Icons.facebook),
                  Icon(Icons.media_bluetooth_on),
                  Icon(Icons.subdirectory_arrow_left),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
