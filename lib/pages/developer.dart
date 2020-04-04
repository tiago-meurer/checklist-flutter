import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About the Developer"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80.0,
              ),
              logo(),
              SizedBox(
                height: 12.0,
              ),
              new Text(
                "Tiago Meurer",
                style: new TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              new Text(
                "Mobile Developer",
                style:
                    new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,                                       ),
              ),
              SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: bio(),
              ),
              SizedBox(height: 55.0),
              new RichText(
                  text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                    new TextSpan(
                        text: 'Professional Contact: ',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                    new TextSpan(
                      text: 'tiagogmeurer@gmail.com',               
                    ),                                                      
                  ])),                
              SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 111.0),
                child: Row(
                  children: <Widget>[instagram(), twitter()],
                ),             
              ),                       
            ],       
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: Center(
        child: new CircleAvatar(
          radius: 100.0,
          backgroundImage: AssetImage("images/Avatar.png"),
        ),
      ),
    );
  }

  Widget bio() {
    return new Text(
      "''Nowadays it is important to optimize our headspace to the best solutions in order to get better results. I hope you enjoy this application!''",
      style: new TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
    );
  }

  Widget instagram() {
    return IconButton(
      icon: Image.asset('images/insta.png'),
      iconSize: 75,
      onPressed: _launchUrlInsta,
    );
  }

  Widget twitter() {
    return IconButton(
      icon: Image.asset('images/twitter.png'),
      iconSize: 50,
      onPressed: _launchUrlTwitter,
    );
  }

}

_launchUrlInsta() async {
    const url = 'https://www.instagram.com/tiagomeur/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchUrlTwitter() async {
    const url = 'https://twitter.com/tiagogilvan';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
