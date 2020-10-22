import "package:flutter/material.dart";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(20, 20, 20, 1),
                Color.fromRGBO(20, 20, 20, 1)
              ],
            )),
            child: Container(
              width: double.infinity,
              height: 350.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.carverpump.com/wp-content/uploads/2016/09/7269033-Portrait-of-happy-smiling-man-isolated-on-white-Stock-Photo-man-men-face-e1481656222290.jpg"),
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Kevin James",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Color.fromRGBO(193, 160, 80, 1)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22.0, horizontal: 8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                              children: <Widget>[
                                Text(
                                  "Ratings",
                                  style: TextStyle(
                                    color: Color.fromRGBO(193, 160, 80, 1),
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "54",
                                  style: TextStyle(
                                    color: Color.fromRGBO(193, 160, 80, 1),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: <Widget>[
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                    color: Color.fromRGBO(193, 160, 80, 1),
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "28.6k",
                                  style: TextStyle(
                                    color: Color.fromRGBO(193, 160, 80, 1),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: <Widget>[
                                Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Color.fromRGBO(193, 160, 80, 1),
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "234",
                                  style: TextStyle(
                                    color: Color.fromRGBO(193, 160, 80, 1),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Bio",
                    style: TextStyle(
                      color: Color.fromRGBO(193, 160, 80, 1),
                      fontStyle: FontStyle.normal,
                      fontSize: 28.0,
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "This is the bio.",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 10.0,
          ),
          Container(
              width: 300.0,
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(193, 160, 80, 1),
                        Color.fromRGBO(110, 90, 46, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Follow user",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
