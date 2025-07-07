import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;


// collection


const usercollection = "User";
const productcollection = "products";
const cartcollection = "carts";
const chatscollection = "charts";
const messagecollection = "messages";
const ordercollection = "orders";
const supportmessages = "support_messages";



