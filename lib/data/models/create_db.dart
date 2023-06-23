import '../../presentation/config/constants.dart';

class CreateDataBase {
  static List<String> sqls = [];
  static List<String> getSQL() {
    sqls.addAll(UserSQL.getSQL());
    sqls.addAll(AccountSQL.getSQL());
    sqls.addAll(AccountTypesSQL.getSQL());
    sqls.addAll(CategorySQL.getSQL());
    sqls.addAll(RecurrencesSQL.getSQL());
    sqls.addAll(TransferSQL.getSQL());
    sqls.addAll(TransactionsSQL.getSQL());
    sqls.addAll(AccountSavingsSQL.getSQL());
    sqls.addAll(AccountSimpleSavingsSQL.getSQL());
    sqls.addAll(SettingsSQL.getSQL());
    sqls.addAll(AcccountAddInterestSQL.getSQL());
    sqls.addAll(DataInsert.getSQL());
    return sqls;
  }
}

// USERS
class UserSQL {
  static const userSql = 'CREATE TABLE ${UserNames.tableName}(${UserNames.id} INTEGER PRIMARY KEY, ${UserNames.name} TEXT, ${UserNames.email} TEXT, ${UserNames.password} TEXT )';
  static const userIndex = 'CREATE UNIQUE INDEX index_users ON ${UserNames.tableName}(id);';
  static const insertUsers =
      'INSERT INTO ${UserNames.tableName}(${UserNames.id}, ${UserNames.name}, ${UserNames.email}, ${UserNames.password}) VALUES (1, "Paul", "paul_brassington@hotmail.com", "a") ,(2, "Campbell", "cambell@weir.com", "a") , (3, "Ting", "yuting_yuting@hotmail.com", "a") , (4, "Roy", "royston@google.com", "a") , (5, "Stephen", "stephen@yahoo.com", "a") , (6, "Jiayuan", "jiayuan@google.com", "a")';
  static List<String> getSQL() {
    return [userSql, userIndex, insertUsers];
  }
}

// ACCOUNTS & USER ACCOUNTS
class AccountSQL {
  static const accountSql = '''
    CREATE TABLE ${AccountNames.tableName}(
      ${AccountNames.id} INTEGER PRIMARY KEY, 
      ${AccountNames.accountName} TEXT, 
      ${AccountNames.description} TEXT, 
      ${AccountNames.balance} DOUBLE PRECISION, 
      ${AccountNames.usedForCashFlow} INTEGER)
    ''';
  static const accountIndex = 'CREATE UNIQUE INDEX index_accounts ON ${AccountNames.tableName}(id);';
  // USER ACCOUNT
  static const userAccountSql = '''
    CREATE TABLE ${UserAccountNames.tableName}(
      ${UserAccountNames.user_id} INTEGER REFERENCES ${UserNames.tableName}(${UserNames.id} ) ON DELETE CASCADE, 
      ${UserAccountNames.account_id} INTEGER REFERENCES ${AccountNames.tableName} (${AccountNames.id}) ON DELETE CASCADE)
    ''';
  static const userAccountIndex = 'CREATE UNIQUE INDEX index_user_account ON ${UserAccountNames.tableName} (${UserAccountNames.user_id} ,${UserAccountNames.account_id});';
  static List<String> getSQL() {
    return [accountSql, accountIndex, userAccountSql, userAccountIndex];
  }
}

// Account Types
class AccountTypesSQL {
  static const accountTypesSql =
      'CREATE TABLE ${AccountTypesNames.tableName}(${AccountTypesNames.id} INTEGER PRIMARY KEY, ${AccountTypesNames.typeName} TEXT, ${AccountTypesNames.iconPath} TEXT )';
  static const accountTypesIndex = 'CREATE UNIQUE INDEX index_account_types ON ${AccountTypesNames.tableName}(id);';
  static const accountTypeEntry =
      'INSERT INTO ${AccountTypesNames.tableName}(${AccountTypesNames.id}, ${AccountTypesNames.typeName}, ${AccountTypesNames.iconPath}) VALUES (1, "Bank Account", "assets/images/accounts/ac03.jpg") ,(2, "Savings", "assets/images/accounts/ac01.jpg") , (3, "Simple Savings", "assets/images/accounts/ac04.jpg") , (4, "Credit Card", "assets/images/accounts/ac02.jpg") , (5, "Mortgage", "assets/images/accounts/ac06.jpg") , (6, "Loan", "assets/images/accounts/ac05.jpg")';
  static List<String> getSQL() {
    return [accountTypesSql, accountTypesIndex, accountTypeEntry];
  }
}

// Category
class CategorySQL {
  static const categorySql =
      'CREATE TABLE ${CategoryNames.tableName}(${CategoryNames.id} INTEGER PRIMARY KEY, ${CategoryNames.categoryName} TEXT, ${CategoryNames.description} TEXT, ${CategoryNames.iconPath} TEXT, ${CategoryNames.usedForCashFlow} INTEGER )';
  static const categoryIndex = 'CREATE UNIQUE INDEX index_categories ON ${CategoryNames.tableName}(id);';
  static const categoryInsert =
      'INSERT INTO ${CategoryNames.tableName}(${CategoryNames.id}, ${CategoryNames.categoryName}, ${CategoryNames.description}, ${CategoryNames.iconPath}, ${CategoryNames.usedForCashFlow}) VALUES (1, "Rent", "payment for renting", "assets/images/category_icons/c008.jpg", 1) ,(2, "Mortgage", "Payment for property", "assets/images/category_icons/c144.jpg", 1) ,(3, "Running Costs", "Cost of running something", "assets/images/category_icons/c051.jpg", 1) ,(4, "Cleaning", "Cost of cleaning contract", "assets/images/category_icons/c034.jpg", 1) ,(5, "Boiler Service", "Annual boiler service cost", "assets/images/category_icons/c031.jpg", 1) ,(6, "Holiday", "Holiday cost", "assets/images/category_icons/c142.jpg", 1) ,(7, "Car Costs", "Car Loan etc", "assets/images/category_icons/c146.jpg", 1) ,(8, "Petrol", "petrol costs", "assets/images/category_icons/c033.jpg", 1) ,(9, "Savings", "loans charges etc", "assets/images/category_icons/c019.jpg", 1) ,(10, "Living Expenses", "from experience", "assets/images/category_icons/c145.jpg", 1) ,(11, "Car Loan", "paying for the car", "assets/images/category_icons/c090.jpg", 1) ,(12, "Car Insurance", "to insure the car each year", "assets/images/category_icons/c112.jpg", 1), (13, "Wages", "payment for my skills", "assets/images/category_icons/c072.jpg", 1), (14, "Bank Interest", "interest given by the bank", "assets/images/category_icons/c008.jpg", 1), (15, "Bank Charges", "charges made by the bank", "assets/images/category_icons/c007.jpg", 1)';
  static List<String> getSQL() {
    return [categorySql, categoryIndex, categoryInsert];
  }
}

// Recurrences
class RecurrencesSQL {
  static const recurrenceSql =
      'CREATE TABLE ${RecurrenceNames.tableName}(${RecurrenceNames.id} INTEGER PRIMARY KEY, ${RecurrenceNames.title} TEXT, ${RecurrenceNames.description} TEXT, ${RecurrenceNames.iconPath} TEXT, ${RecurrenceNames.type} INTEGER, ${RecurrenceNames.noOccurences} INTEGER, ${RecurrenceNames.endDate} TEXT )';
  static const recurrenceInsert =
      'INSERT INTO ${RecurrenceNames.tableName}(${RecurrenceNames.id}, ${RecurrenceNames.title}, ${RecurrenceNames.description}, ${RecurrenceNames.iconPath}, ${RecurrenceNames.type}, ${RecurrenceNames.noOccurences}, ${RecurrenceNames.endDate}) VALUES (1, "Weekly", "Weekly recurrence that has no finish", "assets/images/recurrence_icons/r052.jpg", 0, 0, null) ,(2, "Monthly", "Monthly recurrence that has no finish", "assets/images/recurrence_icons/r003.jpg", 1, 0, null) ,(3, "Quarterly", "Quarterly recurrence that has no finish", "assets/images/recurrence_icons/r064.jpg", 2, 0, null) ,(4, "Yearly", "Yearly recurrence that has no finish", "assets/images/recurrence_icons/r065.jpg", 3, 0, null) , (5, "Weekly Occurr", "Weekly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r061.jpg",0, 5, null) ,(6, "Monthly Occurr", "Monthly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r054.jpg", 1, 5, null) ,(7, "Quarterly Occurr", "Quarterly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r066.jpg", 2, 5, null) ,(8, "Yearly Occurr", "Yearly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r067.jpg", 3, 5, null) ,(9, "Weekly End Date", "Weekly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r063.jpg", 0, 0, "2020-10-10T00:00:00.000") ,(10, "Monthly End Date", "Monthly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r019.jpg", 1, 0, "2020-10-10T00:00:00.000") ,(11, "Quarterly End Date", "Quarterly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r021.jpg", 2, 0, "2020-10-10T00:00:00.000") ,(12, "Yearly End Date", "Yearly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r062.jpg", 3, 0, "2020-10-10T00:00:00.000")';
  static const recurrenceIndex = 'CREATE UNIQUE INDEX index_recurrences ON ${RecurrenceNames.tableName}(${RecurrenceNames.id});';
  static List<String> getSQL() {
    return [recurrenceSql, recurrenceInsert, recurrenceIndex];
  }
}

// Transfers
class TransferSQL {
  static const transferSql =
      'CREATE TABLE ${TransfersNames.tableName}(${TransfersNames.id} INTEGER PRIMARY KEY, ${TransfersNames.user_id} INTEGER REFERENCES ${UserNames.tableName}(${UserNames.id}) ON DELETE CASCADE, ${TransfersNames.title} TEXT, ${TransfersNames.description} TEXT, ${TransfersNames.fromAccountId} INTEGER, ${TransfersNames.toAccountId} INTEGER, ${TransfersNames.categoryId} INTEGER, ${TransfersNames.recurrenceId} INTEGER, ${TransfersNames.plannedDate} TEXT, ${TransfersNames.amount} REAL, ${TransfersNames.usedForCashFlow} INTEGER, ${TransfersNames.processed} INTEGER )';
  static const transferIndex = 'CREATE UNIQUE INDEX index_transfers ON ${TransfersNames.tableName}(${TransfersNames.id});';
  static const transferUserIndex = 'CREATE INDEX index_transfers_users ON ${TransfersNames.tableName}(${TransfersNames.user_id});';
  static List<String> getSQL() {
    return [transferSql, transferIndex, transferUserIndex];
  }
}

// Planned Transactions
class TransactionsSQL {
  static const transactionSql =
      'CREATE TABLE ${TransactionNames.tableName}(${TransactionNames.id} INTEGER PRIMARY KEY, ${TransactionNames.user_id} INTEGER REFERENCES ${UserNames.tableName}(${UserNames.id}) ON DELETE CASCADE, ${TransactionNames.title} TEXT, ${TransactionNames.description} TEXT, ${TransactionNames.accountId} INTEGER, ${TransactionNames.categoryId} INTEGER, ${TransactionNames.recurrenceId} INTEGER, ${TransactionNames.nextTransactionDate} TEXT, ${TransactionNames.endDate} TEXT, ${TransactionNames.amount} REAL, ${TransactionNames.credit} INTEGER, ${TransactionNames.usedForCashFlow} INTEGER, ${TransactionNames.processed} INTEGER )';
  static const transactionIndex = 'CREATE UNIQUE INDEX index_transactions ON ${TransactionNames.tableName}(${TransactionNames.id});';
  static const transactionUserIndex = 'CREATE INDEX index_transactions_users ON ${TransactionNames.tableName}(${TransactionNames.user_id});';
  static List<String> getSQL() {
    return [transactionSql, transactionIndex, transactionUserIndex];
  }
}

// ACCOUNT SAVINGS
class AccountSavingsSQL {
  static const savingsAccountSql =
      'CREATE TABLE ${AccountSavingsNames.tableName}(${AccountNames.id} INTEGER PRIMARY KEY, ${AccountNames.accountName} TEXT, ${AccountNames.description} TEXT, ${AccountNames.balance} DOUBLE PRECISION, ${AccountNames.usedForCashFlow} INTEGER, ${AccountSavingsNames.savingsRate} REAL, ${AccountSavingsNames.save_recurrenceId} INTEGER, ${AccountSavingsNames.chargeRate} DOUBLE, ${AccountSavingsNames.charge_recurrenceId} INTEGER, ${AccountSavingsNames.accountStart} INTEGER, ${AccountSavingsNames.accountEnd} INTEGER, ${AccountSavingsNames.savingsAccountId} INTEGER, ${AccountSavingsNames.chargeAccountId} INTEGER, ${AccountSavingsNames.lastInterestAdded} INTEGER, ${AccountSavingsNames.interestAccrued} DOUBLE PRECISION, ${AccountSavingsNames.capitalCeiling} DOUBLE )';
  static const savingsAccountIndex = 'CREATE UNIQUE INDEX index_account_saving ON ${AccountSavingsNames.tableName}(id);';
  // USER SAVINGS
  static const userSavingsSql =
      'CREATE TABLE ${UserSavingsNames.tableName}(${UserSavingsNames.user_id} INTEGER REFERENCES ${UserNames.tableName}(${UserNames.id}) ON DELETE CASCADE, ${UserSavingsNames.account_id} INTEGER REFERENCES ${AccountSavingsNames.tableName}(${AccountNames.id}) ON DELETE CASCADE)';
  static const userSavingsIndex = 'CREATE UNIQUE INDEX index_user_account_savings ON ${UserSavingsNames.tableName}(${UserSavingsNames.user_id}, ${UserSavingsNames.account_id});';
  static List<String> getSQL() {
    return [savingsAccountSql, savingsAccountIndex, userSavingsSql, userSavingsIndex];
  }
}

// ACCOUNT SIMPLE SAVINGS
class AccountSimpleSavingsSQL {
  static const simpleSavingsAccountSql =
      'CREATE TABLE ${AccountSimpleSavingsNames.tableName}(${AccountNames.id} INTEGER PRIMARY KEY, ${AccountNames.accountName} TEXT, ${AccountNames.description} TEXT, ${AccountNames.balance} DOUBLE PRECISION, ${AccountNames.usedForCashFlow} INTEGER, ${AccountSimpleSavingsNames.savingsRate} REAL, ${AccountSimpleSavingsNames.addInterestId} INTEGER, ${AccountSimpleSavingsNames.chargeRate} DOUBLE, ${AccountSimpleSavingsNames.charge_recurrenceId} INTEGER, ${AccountSimpleSavingsNames.accountStart} INTEGER, ${AccountSimpleSavingsNames.accountEnd} INTEGER, ${AccountSimpleSavingsNames.lastInterestAdded} INTEGER, ${AccountSimpleSavingsNames.interestAccrued} DOUBLE PRECISION )';
  static const simpleSavingsAccountIndex = 'CREATE UNIQUE INDEX index_account_simple_saving ON ${AccountSimpleSavingsNames.tableName}(id);';
  // USER SIMPLE SAVINGS
  static const userSimpleSavingsSql =
      'CREATE TABLE ${UserSimpleSavingsNames.tableName}(${UserSimpleSavingsNames.user_id} INTEGER REFERENCES ${UserNames.tableName}(${UserNames.id}) ON DELETE CASCADE, ${UserSimpleSavingsNames.account_id} INTEGER REFERENCES ${AccountSimpleSavingsNames.tableName}(${AccountNames.id}) ON DELETE CASCADE)';
  static const userSimpleSavingsIndex =
      'CREATE UNIQUE INDEX index_user_account_simple_savings ON ${UserSimpleSavingsNames.tableName}(${UserSimpleSavingsNames.user_id}, ${UserSimpleSavingsNames.account_id});';
  static List<String> getSQL() {
    return [simpleSavingsAccountSql, simpleSavingsAccountIndex, userSimpleSavingsSql, userSimpleSavingsIndex];
  }
}

// SETTINGS
class SettingsSQL {
  static const settingsSql = 'CREATE TABLE ${SettingNames.tableName}(${SettingNames.id} INTEGER PRIMARY KEY, ${SettingNames.settingName} TEXT)';
  static const settingsIndex = 'CREATE UNIQUE INDEX index_settings ON ${SettingNames.tableName}(id);';
  static String settingsInsert =
      'INSERT INTO ${SettingNames.tableName}(${SettingNames.id}, ${SettingNames.settingName}) VALUES (1, "Auto Processing") , (2, "Auto Archive") , (3, "Bar Chart") , (4, "Currency") , (5, "End Date")';
  // USER SETTINGS
  static const userSettingSql =
      'CREATE TABLE ${UserSettingNames.tableName}(${UserSettingNames.user_id} INTEGER REFERENCES ${UserNames.tableName}(${UserNames.id}) ON DELETE CASCADE, ${UserSettingNames.setting_id} INTGER REFERENCES ${SettingNames.tableName}(${SettingNames.id}) ON DELETE CASCADE, ${UserSettingNames.value} INTEGER )';
  static const userSettingsIndex = 'CREATE UNIQUE INDEX index_user_setting ON ${UserSettingNames.tableName}(${UserSettingNames.user_id}, ${UserSettingNames.setting_id});';
  static List<String> getSQL() {
    return [settingsSql, settingsIndex, settingsInsert, userSettingSql, userSettingsIndex];
  }
}

class DataInsert {
  // static const usersSql = 'INSERT INTO users(name, email, password) VALUES ("Paul", "a", "a"), ("Home", "a", "a");';
  // static const accountSql = 'INSERT INTO accounts (accountName, description, balance, usedForCashFlow) VALUES ("Paul Plain", "a", 100.0, 1), ("Home", "a", 1000.0, 1);';
  // static const userAccountSql = 'INSERT INTO user_account (user_id, account_id) VALUES (1, 1);';
  // static const userAccountSql2 = 'INSERT INTO user_account (user_id, account_id) VALUES (2, 2);';
  static const userSettingsSql =
      'INSERT INTO user_settings(user_id, setting_id, value) VALUES (1, 1, 1), (1, 2, 1), (1, 3, -1), (1, 4, 1), (1, 5, 30251841), (2, 1, 1), (2, 2, 1), (2, 3, -1), (2, 4, 1), (2, 5, 30251841);';
  // static const transactionSQL = 'INSERT INTO plannedTransactions (user_id, title, description, accountId, categoryId, recurrenceId, plannedDate, amount, credit, usedForCashFlow, processed) VALUES ' +
  // '(1, "Paul Wages", "a", 1, 13, 2, "2021-01-02T00:00:00.00000", 2000, 1, 1, 0), ' +
  // '(2, "Home Rental", "b", 2, 13, 2, "2021-02-03T00:00:00.00000", 1000, 1, 1, 0);';

  static List<String> getSQL() {
    return [userSettingsSql];
  }
}

class AcccountAddInterestSQL {
  static const addInterestSql =
      'CREATE TABLE ${AddInterestNames.tableName}(${AddInterestNames.id} INTEGER PRIMARY KEY, ${AddInterestNames.title} TEXT, ${AddInterestNames.description} TEXT, ${AddInterestNames.iconPath} TEXT, ${AddInterestNames.type} INTEGER )';
  static const addInterestInsert =
      'INSERT INTO ${AddInterestNames.tableName}(${AddInterestNames.id}, ${AddInterestNames.title}, ${AddInterestNames.description}, ${AddInterestNames.iconPath}, ${AddInterestNames.type}) VALUES (1, "End of Period", "Interest added at the end of the Savings Period", "assets/images/add_interest_icons/ai001.png", 0) ,(2, "1st each Month", "Interest added at the first of each month", "assets/images/add_interest_icons/ai002.png", 1) ,(3, "End of each Month", "Interest added at the end of each month", "assets/images/add_interest_icons/ai003.png", 2) ,(4, "End of year", "Interest added at the end of each year", "assets/images/add_interest_icons/ai004.png", 3) , (5, "Start of quarter", "Interest added at the start of each quarter", "assets/images/add_interest_icons/ai005.png", 4) ,(6, "End of quarter", "Interest added at the end of each quarter", "assets/images/add_interest_icons/ai006.png", 5) ,(7, "End of fiscal year", "Interest added at the end of fiscal year", "assets/images/add_interest_icons/ai007.png", 6)';
  static const addInterestIndex = 'CREATE UNIQUE INDEX index_add_interest ON ${AddInterestNames.tableName}(${AddInterestNames.id});';
  static List<String> getSQL() {
    return [addInterestSql, addInterestInsert, addInterestIndex];
  }
}
