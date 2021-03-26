import 'package:blog_bank/models/blog_model.dart';
import 'package:blog_bank/services/auth_service.dart';
import 'package:blog_bank/services/blog_database.dart';
import 'package:blog_bank/services/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateBlog extends StatefulWidget {

  static const routeName = '/create_blog';

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {

  final _form = GlobalKey<FormState>();

  final _topicFocus = FocusNode();
  final _contentFocus = FocusNode();

  var _editedBlog = BlogModel(
    id: null,
    title: '',
    content: '',
    topic: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'topic': '',
    'content': '',
    'url': '',
  };

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if(_isInit){
      final blogId = ModalRoute.of(context).settings.arguments as String;

      if(blogId != null){
        _editedBlog = Provider.of<BlogDatabase>(context, listen: false).findById(blogId);
        _initValues = {
          'title': _editedBlog.title,
          'topic': _editedBlog.topic,
          'content': _editedBlog.content,
          'url': _editedBlog.imageUrl,
        };
      }

    }
    _isInit =false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _topicFocus.dispose();
    _contentFocus.dispose();
    super.dispose();
  }



  void _saveForm() async{
    final isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }
    _form.currentState.save();
    if(_editedBlog.id != null) {
      Provider.of<BlogDatabase>(context, listen: false).updateBlog(_editedBlog.id, _editedBlog.title, _editedBlog.topic, _editedBlog.content, _editedBlog.imageUrl, );
    }
    else{
      Provider.of<BlogDatabase>(context, listen: false).addBlog(
          _editedBlog.title,
          _editedBlog.topic,
          _editedBlog.content,
          _editedBlog.imageUrl,
          Provider.of<UserProfileProvider>(context, listen: false).userData.userName,
         DateFormat('yyyy-MMM-dd hh:mm a').format(DateTime.now()),
      );
      print(DateTime.now().toString());
    }
    await Provider.of<BlogDatabase>(context, listen: false).getBlogData();
    await Provider.of<BlogDatabase>(context, listen: false).getParticularUserData();
    Navigator.of(context).pop();
  }

  String _imageUrl;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text(
                    'The blog is not published yet.\nDo you want to close?',
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                  actions: [
                    FlatButton(onPressed: (){
                      Navigator.of(context).pop();
                    },
                        child: Text('No',
                          style: TextStyle(
                            color: Colors.green[300],
                            fontSize: 15,
                          ),)),
                    FlatButton(onPressed: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                        child: Text('Yes',
                          style: TextStyle(
                            color: Colors.green[300],
                            fontSize: 15,
                          ),)),
                  ],
                )
            );
          },
        ),
        title: Text('Create Blog',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      color: Colors.grey[300],
                        child: _imageUrl != null ? Image(
                          image: NetworkImage(
                            _imageUrl,
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ) : Container(),
                    ),
                    Divider(height: 1,),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [

                            TextFormField(
                              onFieldSubmitted: (value) {
                                _imageUrl = value.trim();
                              },
                              validator: (value) {
                                if(value.isEmpty){
                                  return 'Please provide a Url';
                                }
                                return null;
                              },
                              initialValue: _initValues['url'],
                              onSaved: (value) {
                                _editedBlog = BlogModel(
                                  imageUrl: value,
                                  topic: _editedBlog.topic,
                                  title: _editedBlog.title,
                                  content: _editedBlog.content,
                                  id: _editedBlog.id,
                                );
                              },
                              decoration: InputDecoration(
                                prefix: IconButton(
                                  icon: Icon(Icons.info_outline, color: Colors.green[200],),
                                  onPressed: () {
                                    return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text('How to add image link?'),
                                          content: Text(
                                            'The image link should contain the actual image address. To get the correct Image link long press any image and \'Open image in new tab\' Then copy the Url from the browser\'s search bar.'
                                                '\n\nYou can also use any gif\'s link to add a GIF as the blog image. \nClick ✔ to see the preview.',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                                child: Text('OK',
                                                  style: TextStyle(
                                                    color: Colors.green[300],
                                                    fontSize: 15,
                                                  ),))
                                          ],
                                        )
                                    );
                                  },
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.green[200],
                                    )
                                ),
                                labelText: 'Blog Image Url',
                                labelStyle: TextStyle(
                                  color: Colors.green[200],
                                  fontSize: 15,
                                ),
                                hintText: 'https://unsplash.com/photos/xQLWIlXTWcg',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),

                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              initialValue: _initValues['title'],
                              onSaved: (value) {
                                _editedBlog = BlogModel(
                                  imageUrl: _editedBlog.imageUrl,
                                  topic: _editedBlog.topic,
                                  title: value,
                                  content: _editedBlog.content,
                                  id: _editedBlog.id,
                                );
                              },
                              validator: (value) {
                                if(value.isEmpty){
                                  return 'Title can not be Empty.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.green[200],
                                    )
                                ),
                                labelText: 'Blog Title',
                                labelStyle: TextStyle(
                                  color: Colors.green[200],
                                  fontSize: 15,
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(_topicFocus);
                              },
                            ),

                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              initialValue: _initValues['topic'],
                              onSaved: (value) {
                                _editedBlog = BlogModel(
                                  imageUrl: _editedBlog.imageUrl,
                                  topic: value,
                                  title: _editedBlog.title,
                                  content: _editedBlog.content,
                                  id: _editedBlog.id,
                                );
                              },
                              validator: (value) {
                                if(value.isEmpty){
                                  return 'Topic must be provided.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.green[200],
                                    )
                                ),
                                labelText: 'Blog Topic',
                                labelStyle: TextStyle(
                                  color: Colors.green[200],
                                  fontSize: 15,
                                ),
                              ),
                              focusNode: _topicFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(_contentFocus);
                              },
                            ),

                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              initialValue: _initValues['content'],
                              onSaved: (value) {
                                _editedBlog = BlogModel(
                                  imageUrl: _editedBlog.imageUrl,
                                  topic: _editedBlog.topic,
                                  title: _editedBlog.title,
                                  content: value,
                                  id: _editedBlog.id,
                                );
                              },
                              validator: (value) {
                                if(value.isEmpty){
                                  return 'Content can not be Empty';
                                }
                                else if(value.length < 300){
                                  return 'Content must be of atleast 300 Characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.green[200],
                                    )
                                ),
                                labelText: 'Blog Content',
                                labelStyle: TextStyle(
                                  color: Colors.green[200],
                                  fontSize: 15,
                                ),
                              ),
                              focusNode: _contentFocus,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),

                    ],
                ),
              ),
          ),
          GestureDetector(
            onTap: () {
              _saveForm();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.green[100],
              child: Center(
                child: Text('PUBLISH',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
