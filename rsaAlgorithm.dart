import 'dart:io';
import 'dart:math';

class RSAKey {
  int valueOfN(int p, int q) {
    return p * q;
  }

  int valueOfZ(int p, int q) {
    return (p - 1) * (q - 1);
  }

  int valueOfE(int n, int z) {
    var e = 0;

    var testArea = [];
    for (int i = 1; i <= n; i++) {
      testArea.add(i);
    }

    var factorOfZ = factorOfNumber(z);
    for (int i = 0; i < factorOfZ.length; i++) {
      testArea.remove(factorOfZ[i]);
    }

    for (int i = 0; i < testArea.length; i++) {
      if (isRelativelyPrime(testArea[i]) == true) {
        e = testArea[i];
        break;
      }
    }

    return e;
  }

  int valueOfD(int e, int z) {
    var d = 0;
    for (int i = 0; i < 1000; i++) {
      if (((e * i) - 1) % z == 0) {
        d = i;
        break;
      }
    }

    return d;
  }

  generateKey(int n, int z, int e, int d) {
    print("Variables generated:");
    print("n = ${n}\nz = ${z}\ne = ${e}\nd = ${d}");
    print("Public key (n,e) = (${n},${e})");
    print("Private key (n,d) = (${n},${d})");
  }

  /**
   * * Math Tools
   */
  List factorOfNumber(int n) {
    var factors = [];
    for (int i = 1; i <= n; ++i) {
      if (n % i == 0) {
        factors.add(i);
      }
    }

    return factors;
  }

  bool isRelativelyPrime(int n) {
    bool isPrime = true;
    if (n == 0 || n == 1) {
      isPrime = false;
    } else {
      for (int i = 2; i <= n / 2; ++i) {
        if (n % i == 0) {
          isPrime = false;
          break;
        }
      }
    }

    return isPrime;
  }
}

/**
 * * Limited for encript and decript one character only
 */
class RSACripto {
  int encript(int m, int e, int n) {
    return pow(m, e) % n;
  }

  int decript(int c, int d, int n) {
    return pow(c, d) % n;
  }
}

main() {
  print("Welcome to RSA Algorithm");
  print("Enter p: ");
  var p = int.parse(stdin.readLineSync());
  print("Enter q: ");
  var q = int.parse(stdin.readLineSync());

  var rsaKey = RSAKey();
  var n = rsaKey.valueOfN(p, q);
  var z = rsaKey.valueOfZ(p, q);
  var e = rsaKey.valueOfE(n, z);
  var d = rsaKey.valueOfD(e, z);

  rsaKey.generateKey(n, z, e, d);

  print("\nSelect one:");
  print("1. Encript\n2. Decript");
  var opt = int.parse(stdin.readLineSync());

  var rsa = RSACripto();
  if (opt == 1) {
    print("Enter M: ");
    var m = int.parse(stdin.readLineSync());
    var enc = rsa.encript(m, e, n);
    print("Encripted success: ${enc}");
  } else {
    print("Enter C: ");
    var c = int.parse(stdin.readLineSync());
    var dec = rsa.decript(c, d, n);
    print("Decripted success: ${dec}");
  }
}
