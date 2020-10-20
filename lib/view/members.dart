import 'package:flutter/cupertino.dart';

import 'membersIndv.dart';

class Members extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Members',
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(193, 160, 80, 1)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: Color.fromRGBO(193, 160, 80, 1),
            ),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
          height: 120,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MembersIndv('assets/images/alex_turner.png', 'Alex Turner'),
              MembersIndv('assets/images/jamie_cook.jpg', 'Jamie Cook'),
              MembersIndv('assets/images/nick_omalley.jpg', 'Nick O\'Malley'),
              MembersIndv('assets/images/nick_omalley.jpg', 'Nick O\'Malley'),
              MembersIndv('assets/images/nick_omalley.jpg', 'Nick O\'Malley'),
              MembersIndv('assets/images/nick_omalley.jpg', 'Nick O\'Malley'),
            ],
            //itemCount: 5,
            /*itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: Icon(Icons.list),
                        trailing: Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item $index"));
                  },*/
          ),
        )
      ],
    );
  }
}
