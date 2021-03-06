import 'package:flutter/material.dart';

const topPadding = 140.0;
const bottomPadding = 300.0;

const bottomBarColor  = Color(0xC060879D);
const buttonGreen     = Color(0xFF47B53A);
const buttonBlue      = Color(0xFF5586A2);
const buttonRed       = Color(0xFFE16268);

const kWhiteColor     = Color(0xFFFFFFFF);
const kBlackColor     = Color(0xFF000000);
const kTextColor      = Color(0xFF1D150B);
const kPrimaryColor   = Color(0xFFFB475F);
const kSecondaryColor = Color(0xFFF5E1CB);
const kBorderColor    = Color(0xFFBBBBBB);

const gradientOrange  = Color(0xFFAB4919); 
const gradientYellow  = Color(0xFFDFBE20); 
const gradientBlue    = Color(0xFF1E88E5); 
const gradientPurple  = Color(0xFF7C4DFF); 

//Color(0xFFFFD600);
//Color(0xFFC43C00);
//Color(0xFF2962FF);
//Color(0xFF7C4DFF);

const LinearGradient gradienteAzul = LinearGradient(
  colors: [gradientBlue, gradientPurple],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const LinearGradient gradienteAzulDiagonal = LinearGradient(
  colors: [gradientBlue, gradientPurple],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient gradientenNaranjo = LinearGradient(
  colors: [gradientOrange, gradientYellow],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const LinearGradient gradientenNaranjoDiagonal = LinearGradient(
  colors: [gradientYellow, gradientOrange],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

BoxDecoration imagenDeFondo = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/img/seamless555.png"),
    fit: BoxFit.cover,
    //colorFilter: new ColorFilter.mode(Colors.red[100].withOpacity(0.05), BlendMode.dstIn),
  ),
);

BoxDecoration imagenDeFondoLogin = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/img/fondo-login.png"),
    fit: BoxFit.cover,
    //colorFilter: new ColorFilter.mode(Colors.red[100].withOpacity(0.05), BlendMode.dstIn),
  ),
);


