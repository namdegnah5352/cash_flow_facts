class TransactionJourney {
  TransactionJourney({this.step1});

  String? step1;
  String? step2;
  String? step3;
  String? step4;
  String? step5;
  String? step6;
  String? step7;
  String? step8;

  String printTransactionJourney() {
    String ans = '';
    ans += 'step 1: ${step1 ?? 'null : '}';
    ans += 'step 2: ${step2 ?? 'null : '}';
    ans += 'step 3: ${step3 ?? 'null : '}';
    ans += 'step 4: ${step4 ?? 'null : '}';
    ans += 'step 5: ${step5 ?? 'null : '}';
    ans += 'step 6: ${step6 ?? 'null : '}';
    ans += 'step 7: ${step7 ?? 'null : '}';
    return ans;
  }
}

enum TransactionEnum { step1, step2, step3, step4, step5, step6, step7, step8 }
