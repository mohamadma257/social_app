import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_media/colors/app_color.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/pages/comment_screen.dart';
import 'package:social_media/providers/user_provider.dart';
import 'package:social_media/services/cloud.dart';

class PostCard extends StatefulWidget {
  final item;
  const PostCard({super.key, required this.item});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentCount = 0;

  getCommentCount() async {
    try {
      QuerySnapshot comment = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.item['postId'])
          .collection('comments')
          .get();
      if (this.mounted) {
        setState(() {
          commentCount = comment.docs.length;
        });
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  void initState() {
    getCommentCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).userModel!;

    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              children: [
                widget.item['profilePic'] == ""
                    ? CircleAvatar(
                        backgroundImage: AssetImage('assets/images/man.png'))
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.item['profilePic']),
                      ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item['displayName']),
                    Text("@" + widget.item['username']),
                  ],
                ),
                Spacer(),
                Text(widget.item['date'].toDate().toString()),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: widget.item['postImage'] != ""
                      ? Container(
                          margin: EdgeInsets.all(12),
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.item['postImage'],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item['description'],
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    CloudMethods().likePost(widget.item['postId'], userData.uid,
                        widget.item['like']);
                    getCommentCount();
                  },
                  icon: widget.item['like'].contains(userData.uid)
                      ? Icon(
                          Icons.favorite,
                          color: kPrimaryColor,
                        )
                      : Icon(Icons.favorite_outline),
                ),
                Text(widget.item['like'].length.toString()),
                Gap(20),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CommentScreen(postId: widget.item['postId']),
                        ));
                    getCommentCount();
                  },
                  icon: Icon(Icons.comment),
                ),
                Text(commentCount.toString()),
                Spacer(),
                IconButton(
                    onPressed: () {
                      CloudMethods().deletePost(widget.item['postId']);
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
