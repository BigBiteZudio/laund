import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Laundry.dart';
import 'VerifyCode.dart';
import 'authentication/auth_service.dart';
import 'authentication/phone_number.dart';


class LogSign extends StatefulWidget {
  const LogSign({super.key});

  @override
  State<LogSign> createState() => _LogSignState();
}

class _LogSignState extends State<LogSign> {

  late GoogleSignInAccount _userObj;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
    "636086190369-c7cnq0tblmfapqqf8kdrdj6u7rvr8l7l.apps.googleusercontent.com",
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Check if user is not null before accessing properties
      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Laundry()));
      } else {
        //print("User is null");
      }
    } catch (e) {
      //print(e.toString());
    }
  }


  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController logInEmailController = TextEditingController();
  final TextEditingController forgotPasswordEmailController = TextEditingController();
  final TextEditingController signupPasswordController = TextEditingController();
  final TextEditingController logInPasswordController = TextEditingController();
  final TextEditingController signupRePasswordController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  bool signupIsPasswordVisible = false;
  bool logInIsPasswordVisible = false;
  bool signupIsRePasswordVisible = false;
  bool showPasswordReset = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150.0),
            child: AppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.blue
                  ),
                  child: const Center(child: Text("Laund",
                    style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              const TabBar(
                indicatorColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'SIGNUP'),
                  Tab(text: 'LOGIN'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SignupTab(),
                    showPasswordReset ? forgotPasswordContainer() :
                    LoginTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SignupTab() {
    return Form(
      key: signUpFormKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              "Create Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              elevation: 6,
              color: Colors.white,
              child: TextFormField(
                controller: signupEmailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.email_outlined),
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email ID",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              elevation: 6,
              color: Colors.white,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: signupPasswordController,
                obscureText: !signupIsPasswordVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      signupIsPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        signupIsPasswordVisible = !signupIsPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              elevation: 6,
              color: Colors.white,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: signupRePasswordController,
                obscureText: !signupIsRePasswordVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Re-Enter Password",
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      signupIsRePasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        signupIsRePasswordVisible = !signupIsRePasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: GestureDetector(
              onTap: () async {
                if (signUpFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Account Created")));
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Laundry()));

                }
                final message = await AuthService().registration(
                  email: signupEmailController.text,
                  password: signupPasswordController.text,
                );
                if (message!.contains('success')) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Laundry()));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account Created"),
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 2.6),
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueAccent,
                ),
                child: const Center(
                  child: Text(
                    "Join in Community",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 50, left: 50),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "By creating an account, you agree to Wasty ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "Terms of use ",
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(
                    text: "and ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "Privacy Policy ",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 7,
                  thickness: 2,
                ),
              ),
              Text("or connect with",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
              Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 7,
                  thickness: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/google.png"),
                                  //NetworkImage("data:image/png;base64,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")
                              )
                          ),
                        ),
                      ),
                      TextButton( onPressed: () async {
                        signInWithGoogle();
                      },
                        child: const Text("Google",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Apple.png"),
                                  //NetworkImage("data:image/png;base64,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")
                              )
                          ),
                        ),
                      ),
                      const Text("Apple",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/phone.png"),
                                  //NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ1T7xedFjh3BJXSegaGtManCltVSvjCQDfQuBKjm_-Ht7oWQCOQ0rFCClFu6zzHMyYgc&usqp=CAU")
                              )
                          ),
                        ),
                      ),
                      TextButton( onPressed: () async {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const Phone()));
                      },
                          child: const Text("Phone No.",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black))),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/facebook.png"),
                                  //NetworkImage("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw8QEBIPEg8QFRMNFRUVFRIRDxARFQ4RFREXFhYRFRYYHSggGSYlGxUVITEhJSk3Li8uFyAzODMsQyktLisBCgoKDg0OGxAQGi4mHyU2LS0rLS0tLS0uKy0tKystLS8rLystLS0vLS0tLSsrKy0tLS0rLS4wLS0vLS0tLS0uLv/AABEIAOEA4QMBEQACEQEDEQH/xAAbAAEBAAIDAQAAAAAAAAAAAAAABwUGAgMEAf/EAEkQAAIBAgEGCQYLBgUFAAAAAAABAgMRBAUGEiExQQcTIlFhcXKBkTJCUqGywhQjJTNTkqKxs8HRFTQ1c4KTJENiY9IWROHi8P/EABoBAQADAQEBAAAAAAAAAAAAAAAEBQYDAgH/xAA1EQEAAQIDBAcIAgMAAwAAAAAAAQIDBAUREiExQVFxgbHB0fATIjI0YZGh4TNCFBXxIyRi/9oADAMBAAIRAxEAPwC4gAAAAAAAAAGHyhnNhKN06qnJebS5b6rrUu9ky1gL9zfFOkfXd+0C/meGtbpq1nojf+vvLXsZn1N6qVCK6aknL7MbfeWNvKKf71fb14Ku7nlU/wAdH38o82JxGdONn/naK5oRhH12v6yXRl+Hp/rr1oNeaYqv++nVEf8AWPqZRry8qvWfXVm/zJFNi1Twpj7Qi1Yi9Vxrq+8uiVWT2yb622dIpiOEOc1TPGSM2tja6m0JiJfImY4O6nj68fJr1l1VZr8znNm3PGmPtDpTfu08K5+8vdQzmxsNleTXNNQnfvav6zhXgMPV/X7bkmjMsVRwr169J/bL4TPqqtVWjCXTBuD8HdP1ES5lFE/BVMde/wAk61nlyP5KYnq3ebPYHOzB1dTm6be6qtFfW8n1kC7l1+jhGvV5cVnZzbDXOM7M/Xd+eH5ZyMk1dNNPY1rTIMxpulYxMTvh9Pj6AAAAAAAAAAAAAAAAPjdtfMBrWWM8qFK8KK42a3p2pxfa87u8Szw+WXK99fux+fXWqMVm9q37tv3p/H359jTMp5cxOIvxlR6L8yPJh4Lb33LmzhLVn4Y39PP11KDEY2/f+Ord0Ruj116scSUUAAAAAAAAAAPZk/KlfDu9KrKK9HbF9cXq79pxu4e3dj3417/u72MTdsT/AOOrT6cvs3HI+etOdoYiPFy9ON3B9a2x9a6SmxGVVU77U6x0c/2vsNnNFXu3o0np5fru+ra6dSMkpRaalrTTTTXOmiqmJidJXVNUVRrHByPj6AAAAAAAAAAAAB4Mr5Xo4WGnUlt8mC1ym+ZL89h3w+GuX6tKI7eUI2JxVvD07Vc9Uc56k7y5nHXxTcW9Cnupxe3tvzvu6DRYbA27G+N9XT5dDL4vMLuI3Tup6I8enuYa5MQS4C4C4C4C4C4C4C4C4C4C4C4C4GSyNlyvhZXhK8G+VTldxl+j6V6yNiMJbvx70b+nmlYXGXcPPuTu6OX6UXIeXaOLjyHoziuVTk1pR6VzrpXqM7icJcsT73DpanCY23iY93dPOObKkVMAAAAAAAAAADB5yZx08JHRVpVpLkwvqivSnzLo2v1qdg8FVfnWd1PT5K/HY+nDRpG+qeEeM+t6aY3GVK03UqScpS3vcuZLcug0lu1Tbp2aI0hlLt2u7VNdc6y6bnRzLgLgLgLgLgLgLgLgLgLgLgLgLgLgLgc6FeUJKcJOMoO6knZpnmqmKo2ao1h6oqqoqiqmdJhRc1s6I4m1KraNZbN0a1t8eZ868OjO43ATZ9+jfT3eulqMBmUX/cr3Vfier6/RspWrUAAAAAAAAwWdOcEcJDRjZ1qi5Ed0V6cuj7/G07BYOcRVrPwxx8oV+Px0YanSN9U8I8Z9b0wr1pVJOc5OUpu7k9rZpqaYpiKaY0iGTrrqrqmqqdZlwPTyAAAAAAAAAAAAAAAAAAAB9jJppptNO6admmtjTExE7pImYnWFHzQzk+EriarSrQWp7OOit66VvXfz2zmPwPsZ26Ph7v10NRluYe3j2dfxR+f30/fq2crFsAAAAABj8uZVhhaMqste6Mb66k3siv8A7Ymd8Nh6r9yKI7fpCPisTTh7c11dkdMpLjsZOtUlVqSvKbu3zcyXMlsNZbt026Yop4Qxt27VdrmuvjLoPbmAAAAAAAAAAHKnCUmoxTlKWyMU5N9SW0TMRGs8H2KZqnSI1lncFmfjaqu4Rpp/Sz0X4JNrvRAuZlh6N2uvV6hYWsqxNca6RHXPlqytLg+n52KiuzScvW5IiznFPKj8/pMpyOrnX+P27Xwfc2Lf9n/3PP8Auf8A4/P6epyOOVz8ft01OD+p5uJg+ulKPvM9xnFPOifv+nicjr5Vx9v28dbMbGLY6MuqpJP1xX3nanNrE8dY7P241ZNiI4TE9s+TB5SybWw01CrDRlJaSWlGV43avqfOmTbN+i9TtUTrCvv4e5Yq2bkaS8h1cQABzo1ZQkpxk1KDTUltTW8+VUxVExPB6pqmmYqp3TCrZsZbji6OlqVSnZVIrc90l0P9VuMrjMLOHuacp4evo1+BxcYi3r/aOMeuUswRE0AAAPjdtb3eoCT51ZaeLrtp/FUrxprnW+ffbwsavA4X2FvSfinj5djIY/FziLusfDHDz7e5hbkxBLgLgLgLgLgLgLgLgLgZ3NvNurjHpXcKMXrnbXJ74wW/r2Lp2EHGY6jDxpxq6PNPwWX14ideFPT5KRkrJFDDR0aVNK+2T1yn2pbX9xnb+IuXp1rnyaexhrViNLcec9r3HB3AAAABOOEn96p/yV+JM0WUfwz1+EM1nX81PV4y1O5aqcuAuAuBkMhZVlhK8ayu1snH04PauveulEfE4eL9uaJ7PpKThcTVh7kVxw5x0wr9CtGpGM4tOM0pJremrpmSqpmmZpnjDZU1RVTFVPCXYeXoAAapwgZX4qgsPF8vE3T/ANNJeV47Oq5aZXh9u57SeFPf+uKpzbE+ztezjjV3c/vwTW5o2ZLgLgLgLgLgLgLgLgLgZfNjIzxldQ1qnDlVJLdHdFdL2eL3EXGYmMPb2uc8PX0S8FhZxF3Z5Rx9fVWqFGNOMYQioxgklFbEluMpVVNUzVVxlr6aYpiKaY3Q7Dy9AAAAAATfhK/eqf8AJX4kzRZR/DV1+EM1nX81PV4y1K5aqguAuAuAuBvvBzle6lhJPXC86d/Rvyodzd+98xRZth9Ji9HVPgv8nxOsTZq5b48YbwUq9ADAjWcWU3icTUq35N9GHRTjqj4633mvwlj2NqKOfPr9bmNxl/296qvlwjqj1qxtySilwFwFwFwFwFwFwFwFwKvmPk1UMJCTXLxHxkn0SXJXdG3e2ZbMr/tL8xyjd5/lrMsseysRPOrfPh+GwEBYAAAAAAAJtwl/vVP+SvxJmiyf+Grr8IZvOf5qerxlqNy2U5cBcBcBcD0ZPxsqFWFaHlUpKVvSW+PerrvOd23F2iaKubpauzariunjC14avGpCNSLvGpFST501dGNrpmiqaZ4w21FUV0xVHCXYeXpg89MocRg6rTtKr8XHdrnqbXVHSfcTcvs+1v0xPCN89n7Qcxveyw9UxxndHb+kiNWyQAAAAAAAAAAd2EocZUp0vpZxh9aSj+Z5rq2KZq6Imfs926NuuKemYj7rlCKSSSskrJcyRipnWdZbeI03Pp8fQABwq1Ywi5ykoxgm3JuyiltbZ9ppmqdI4vlVUUxrPBpOU+EKKbjh6Okl/mVG4p9KitdutourOTzMa3KtPpHmpb2cxE6WqdfrO78f8Yp5/wCN9DD/ANup/wAyT/qLHTP3jyRP9xiOin7T5n/X+N9DD/26n/M+/wCosdM/ePI/3GI6KftPmwuW8s1cZONSqoJwjorQi0rXb3t85Mw+GosUzTRr070LE4mvEVRVXpu3bmOO6OAAAAABTuDnH8ZhXSb5WGlb+iXKj69Jf0mbzazsXtuP7d8eoabKL23Z2J40908PGG1lWtU94UMZedCgn5KdSS6ZPRj90/Evsmt+7VX2eM+Cgzm571Nvt8I8Wjl2pAAAAAAAAAAAymasNLG4Zf7if1bv8iLjZ0w9fUlYGNcRR1rMZBsAAAA0vhNx8oUaVBO3HycpdMaduS/6pJ/0lxk9qKq6q55cO1TZzdmm3Tbjnx7E5NCzwAAAAAAAAAAbTwc4zQxnFt6sRBq3+qPKT8FPxKvNre1Y2uie/d5LTKLmzf2emO7f5qiZppkhz5xPGY+tr1U9GC6NGCv9pyNXl1Gzhqfrv/LJ5lXtYmr6aR+GBuTkEuAuAuAuAuAuAuAuAuBmM0H/AI7D9v3WRMf8vX1JmA+Zo9cpWQyLXAAABPOFP5zD9mp98S/yb4a+zxUGdfFR2+DRrl0pC4C4C4C4C4C4C4C4C4HuyDieKxVCpe2jVhfsuSUvU2cMTRt2a6fpLvha9i9RV9YW4xrZoblirp4mvP0qtR+NRm0sU7NqmPpHcxmInW7XP1nveO52cS4C4C4C4C4C4C4C4C4GYzPf+Pw3b91kPH/L19SZgPmaPXKVmMi1oAAATrhU+cw3Zqe1Ev8AJfhr7PFQ5z8VHb4NGuXSkLn0LgLgLgLgLgLgLgLgG/UBY/29EyP+LLX/AORCO1Z3lJ+k2/F3NbEaRoyVU6zMuFz6+FwFwFwFwFwFwGkHx80lzjQNJc40GZzOl/j8N2/dZEx/y1fUmYD5mj1ylaDINaAAAE54Vn8ZhuzU9qJf5L8NfZ4qHOfio7fBomkucu9FIaS5xoGkucaD7cPpcBcBcBcBcBcAw+Mz+1ZekQ/8eE//ACZYaorNrmbXgyZE6xqhTGk6ONw+FwFwFwFwFwFwKvwe4enLAU24Qb0qmtxTfzjMxmldUYmdJ6O5p8spicPGsdPe2T4HS+ip/Uj+hX+0r6ZT9inoPgdL6Kn9SP6D2lfTJsU9DlHDU07qnBNb1GKaPk11Txk2aY5O08vQAAAddSjCXlQi7elFO3ieoqmOEvk0xPFw+B0voqf1I/offaV9MvmxT0HwOl9FT+pH9B7Svpk2Keg+B0voqf1I/oPaV9MmxT0Ijlusp4mvJWtKrO1lZaOm0vUkbHD07NqmJ6I7mPxFW1eqn6y8Vzs4lwFwFwFwFwFz6Mh+z5cxH9tCT/j1OjK0NDEV4ehVqLwqNHuxO1apn6R3PF+NLtUfWe95LnVyLgLgLgLgLgLgV7g5/h9PtVPxGZXNfmZ7O5qMs+Wp7e9sxXJ4AAAAAAAAAAdGOrqnSqVHspQlLujFv8j3bp264p6Z0ea6tmmap5IEmbhii4C4C4C4C4C4BsCu/wDTvQZX/Lar/GT3PfD8XlDEK2qUlNdOnBSb8Wy+y+vaw1E9n2UWYUbOIq+7B3JiGXAXAXAXAXAXAr3Bx/D6faqfiMyua/Mz2dzT5Z8tT297ZyuTwAAAAAAAAAAwee+I4vJ+IfpQ0P7klD7pE3L6NrE0R2/beiY+vZw9U9n33Itc1zKFwFwFwFwFwFwPZkbD8biaFK1+MqwT6nNX9Vzlfr2LVVXREuuHo27tNP1heTEtimPCvg9GvRrrZVg4PtQldeKn9k0WTXNbdVHROv3/AOKHN7eldNfTu+3/AFoxdKcAAAAAABYODf8Ah9PtVPxGZTNfmZ7O5p8t+Xp7e9s5XJ4AAAAAAAAAAabwp4jRwcIfS1Yp9mMZS+9RLbJ6Nb8z0QrM2q0sxHTKVGmZwAAAAAABtPBtg+Mx0Z7sPCU+i7Wgl9pvuKzNbmxh5jpmI8fBY5Xb2r+vRv8ABXjLNK1nhEyfx2BnJLlYZqquqN1P7Lk+4scrvezxERPCd3l+UHMbXtLE/Tf67EcNWzAAAAAAAD40gGiuZH3UNFcyGozeZSX7Qw2rz/ckQ8wn/wBavqS8B8xT65LeY5qgAAAmnC4vjMN2antQNDknw19nio8440dvg0DRXMi81UxormQ1BI+D6AAAAAAABUuCvJ+hh6mIa14ido9indX+s5+Bm85vbV2Lccu+f1o0GU2tm3NfT3R6lu5TrVxqQUk4tXUk0096e1H2JmJ1h8mNdyC5eya8LiauHd/i5PRb86D1wl9VrvubXDXovWqa459/NksRZm1cmj1o8Fzs4lwFwFwFwFwFwFwFwM3mU/lDDdv3JETMPlq+rxS8B8xT65LgY5qQAAAmnC785huzU9qBock+Gvs8VJm/Gjt8E/uXamLgLgLgLgLgLgLgLgduEw86tSFKCvKrJRiumTsrnmuumimaquEPVFE11RTHGV9ybg40KNOhHyaMVFdNltfXt7zE3bk3K5rnm19uiKKIpjk9JzewDQuFPIunTjjILlUeRUtvpt8mXdJ/a6C6yfE7NU2Z5746/wBqnNMPtUxcjjHHqS+5o1CXAXAXAXAXAXAXAXAzmZL+UMN2/ckQ8w+Wr6vFLwPzFPrkuJjmpAAACZ8L3zmF7NT2oGhyT4a+zxUmb8aO3wT65eKYuAuAuAuAuAuAuAuBv/BZkXTqSxs1yaV4U775tcqXcnb+p8xSZxidKYsxz3z1clxlWH1mbs8t0KcZ1eAADhXoxnGUJRTjNOMovZKLVmn3H2mqaZiY4w+TEVRpKFZ0ZEngsTKi7uD5VOb8+m9netj6V1GzwmJjEWorjjz62VxWHmxcmnlyYi5JRy4C4C4C4C4C4C4GczIfyhhu37kiHmHy1fV4peB+Yp9clzMc1AAAATLhf+cwvZqe1A0OSfDX2eKkzfjR2+Ce3LxTlwFwFwFwFwFwFwPZkjJ1TFVoUKa5VR2vuhHzpvoSuzlfvU2aJrq4Q6WbVV2uKKV5yXgKeGo06FNWjSjZc755Ppbu31mLvXartc11cZay3bpt0RRTwh6jm9gAABgc8c3o47DuGpVad5UpvdK2uL6JWSfc9xNwOLnD3NeU8fX0RcXhov0ac44IhiKM6c5U5xcZU24yi9sZJ60zX01RVEVU8JZiqmaZ2Z4uu56fC4C4C4C4C4C4GdzH/iOF7fuSIWYfLV9Xil4H5in1yXQxzTgAABMeGD5zC9mp7UDQ5J8NfZ4qXNuNHb4J5cvVOXAXAXAXAXAXA+q71La9y39B8IjVZMwM2PgdLjakV8Irrlf7UNqpr1N9PUZXMsb7evZp+GPzPT5NHgcJ7Gnaq+Kfx9G2FYngAAAAAaXn/mh8Ki8TQj8fBcqK/wC4gt3aW579nNa2y3H+xn2dfwz+P1/1XY7B+1jbo+LvSKSabTTTWpp6mmtqaNRxZ+Y03S+XD4XAXAXAXAXAzmY/8Rwvb9yRDzD5avq8UvA/z0+uS7GNacAAAJhwxfOYXs1PagaHI/hr7PFS5txo7fBPLl6py4C4C4C4C4C4FN4O8znDRxuIjyttGnJeRzVZLn5lu27bWz2Z5hrrZtzu5z4R4rvAYLZ0uXOPKPFRSiW4AAAAAAABpGfOZCxV8Th0o19soalHEfkpdOx7+ct8vzKbP/jufD3fpXY3Axd9+j4u9Ja1OUJOE4yjKDtKMk04tbU09hpqaoqjWOCgqpmmdJcLn18LgLgLgLgZ3MZ/KOF7fuSIeYfLV9Xil4H+eldzGtMAAAEv4Y/nML2avtQNFkfw19nips2409vgndy9U5c+BcBcBcD6tepbXu53zB9iNVNzFzE0XHFYuHKWunQkvI5p1Fz80d2/XqWfzDM9dbdmd3OfLzXWCwGz79yN/KPNRihWwAAAAAAAAAAa5nXmhh8fHSfxdaK5NWK280Zrzl61uZPwePuYadONPR5dCJicJRfjfunpR/LuQsTgqnF16dr+TNXcKnTGX5beg1GHxNq/TtUT2c4UF7D3LM6VQxlyQ4FwFwFwM7mK/lHC9v3JEPMPlq+rxS8D/PSvJjGmAAACXcMnzmF7NX2oGiyP4a+zxU2bcae3wTq5eqcuAuAuB7MlZMr4qoqVGnKcnttsivSk9kV0s5Xr1uzTtVzpDras13atmmFczPzHo4K1WrapiPS8yj0U0/aevqMxjcyrv+7Tup/M9fkvsLgabPvTvq9cG3FYnAAAAAAAAAAAAAdGNwdKtB0qtOM4S2xnFNPp/wDJ7ouVW6tqmdJeaqKao0qjWE5zj4MnrqYOd9/EVJa+qE390vEvcLnP9b0dseMeX2VN/LOdr7J7j8BWw8+LrUp05LdOLV1zrc10ovLd2i5TtUTrCruWq7c6VRo81z25lwM9mI/lLC9v3JEPMflq+rxS8D/PSvRjGlAAACW8MvzmF7FX2oGiyP4a+zxU2a/17fBObl6qC4HbhcPUqzVOnCU5y2RhFyk+5HmuumiNqqdIeqaKq50pjVvubvBnVnaeLnxcfooNSqPtS2R7r9xTYnOaKfdsxrPTPBaWMsmd9ydPopWS8mUMLTVKjSjCK3RWuT55PbJ9LKC7euXatqudZW9u3RbjSmNHsOT2AAAAAAAAAAAAAAAAPPjcFRrwdOrThUi/NnFSXXrPdu5XbnaonSfo81UU1RpVGrTMr8GGEqXlQqTot+a/jYeDekvrdxbWc5u07rkbX4ny/CBdy23VvpnRp+UuDnKNK7hCFaPPSmk7dMZ2fcrlpazfD18ZmOv9aoFzLr1PDe6sz8mYijlLC8bQrQ+Mfl0pxXkS3taz1jb1uvC17FUTu5T9XzCWq6L9O1EwuBkGhAAACZ8LeEq1q2FjSpVKkowqXjThKbV5RtdRWrY/A0GTXKaKK5rmI4cd3SqcyoqrmmKY14tcydwfZSrbaUaSe+tNR+zG8vFE67muGo4Tr1R/yESjL71XGNOtt2SOC3DwtLEVp1X6EFxUOpvXJ9zRWXs7uVbrdOnXvny7061llEb651/Ddcm5Lw+GjoUaMKa36EUnLpk9sutlTdvXLs611TKwot0URpTGj2HJ7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP//Z")
                              )
                          ),
                        ),
                      ),
                      const Text("Facebook",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

        ],
      ),
    );
  }

  Widget LoginTab() {
    return Form(
      key: logInFormKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Login to your Account",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: TextFormField(
                controller: logInEmailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.email_outlined),
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email ID",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: logInPasswordController,
                obscureText: !logInIsPasswordVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      logInIsPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        logInIsPasswordVisible = !logInIsPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35, top: 10, bottom: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showPasswordReset = true;
                  });
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Laundry()));

            },
            child: Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2.6),
                  )
                ],
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueAccent,
              ),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 7,
                  thickness: 2,
                ),
              ),
              Text("or connect with",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
              Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 7,
                  thickness: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/google.png"),
                                //NetworkImage("data:image/png;base64,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")
                              )
                          ),
                        ),
                      ),
                      TextButton( onPressed: () async {
                        signInWithGoogle();
                      },
                        child: const Text("Google",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Apple.png"),
                                //NetworkImage("data:image/png;base64,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")
                              )
                          ),
                        ),
                      ),
                      const Text("Apple",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/phone.png"),
                                //NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ1T7xedFjh3BJXSegaGtManCltVSvjCQDfQuBKjm_-Ht7oWQCOQ0rFCClFu6zzHMyYgc&usqp=CAU")
                              )
                          ),
                        ),
                      ),
                      TextButton( onPressed: () async {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const Phone()));
                      },
                          child: const Text("Phone No.",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black))),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 35,
                          width: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/facebook.png"),
                                //NetworkImage("data:image/jpeg;base64,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")
                              )
                          ),
                        ),
                      ),
                      const Text("Facebook",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget forgotPasswordContainer() {
    return Column(
      children: [
        Row(
          children: [
            Center(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    showPasswordReset = false;  // Hide password reset and show TabBarView
                  });
                }, icon: const Icon(Icons.arrow_back),
              ),

            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "ENTER YOUR EMAIL",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: TextFormField(
              controller: forgotPasswordEmailController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email_outlined),
                contentPadding: EdgeInsets.all(20),
                filled: true,
                fillColor: Colors.white,
                hintText: "Email ID",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            setState(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const verifyCode()));
            });
          },
          child: Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 2.6),
                )
              ],
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueAccent,
            ),
            child: const Center(
              child: Text(
                "Send Code",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ),
        ),
        const Spacer(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Divider(
                indent: 10,
                endIndent: 7,
                thickness: 2,
              ),
            ),
            Text("or connect with",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
            Expanded(
              child: Divider(
                indent: 10,
                endIndent: 7,
                thickness: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 5,
              color: Colors.white,
              child: Container(
                height: 50,
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 35,
                        width: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/google.png"),
                              //NetworkImage("data:image/png;base64,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")
                            )
                        ),
                      ),
                    ),
                    TextButton( onPressed: () async {
                      signInWithGoogle();
                    },
                      child: const Text("Google",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              color: Colors.white,
              child: Container(
                height: 50,
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 35,
                        width: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/Apple.png"),
                              //NetworkImage("data:image/png;base64,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")
                            )
                        ),
                      ),
                    ),
                    const Text("Apple",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 5,
              color: Colors.white,
              child: Container(
                height: 50,
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 35,
                        width: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/phone.png"),
                              //NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ1T7xedFjh3BJXSegaGtManCltVSvjCQDfQuBKjm_-Ht7oWQCOQ0rFCClFu6zzHMyYgc&usqp=CAU")
                            )
                        ),
                      ),
                    ),
                    TextButton( onPressed: () async {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const Phone()));
                    },
                        child: const Text("Phone No.",
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black))),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              color: Colors.white,
              child: Container(
                height: 50,
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 35,
                        width: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/facebook.png"),
                              //NetworkImage("data:image/jpeg;base64,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")
                            )
                        ),
                      ),
                    ),
                    const Text("Facebook",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),

      ],
    );
  }
}