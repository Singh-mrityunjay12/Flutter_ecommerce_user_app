import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth
    .currentUser; //jo bhi user login hoga usaka sara data ham is variable ke through access kar lenge firebase se this variale is user type

//collection
const userCollection = "users";
const productCollection = "products";
const cartCollection = "cart";
const chatCollection = "chats";
const messageCollection = "messages";
const orderCollection = "orders";
