import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/config/generated/assets.gen.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';
import 'package:money_scope/src/domain/entities/user_entity.dart';
import 'package:money_scope/src/presentation/providers/user/user_provider.dart';
import 'package:uuid/uuid.dart';

class UserRegistrationPage extends ConsumerStatefulWidget {
  const UserRegistrationPage({super.key});

  @override
  ConsumerState<UserRegistrationPage> createState() =>
      _UserRegistrationPageState();
}

class _UserRegistrationPageState extends ConsumerState<UserRegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();

  // final TextEditingController _nameController = TextEditingController();

  String? _selectedCountry;

  final List<String> _countries = const [
    "India",
    "United State",
    "United Kingdom",
    "UAE",
  ];

  final List<String> _employmentTypes = const [
    "Salaried",
    "Self-employed",
    "Student",
    "Freelancer",
    "Business",
  ];

  String? _selectedEmploymentType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(
                child: CircleAvatar(
                  radius: 52,
                  backgroundImage: Assets.images.moneyScope.provider(),
                ),
              ),

              Center(
                child: Text(
                  "Create Your MoneyScope Account",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 24),

              Text(
                "Full Name",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(prefixIcon: Icon(Icons.person)),
              ),

              Text(
                "Email",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                ),
              ),

              Text(
                "Country",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              DropdownButtonFormField(
                initialValue: _selectedCountry,
                hint: Text("Select Country"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _countries
                    .map(
                      (value) =>
                          DropdownMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
              ),

              Text(
                "Phone",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  counter: Offstage(),
                  prefixIcon: Icon(Icons.phone_android_rounded),
                ),
              ),

              Text(
                "Monthly Income",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _incomeController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  counter: Offstage(),
                  prefixIcon: Icon(Icons.money),
                ),
              ),

              Text(
                "Employment Type",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              DropdownButtonFormField(
                initialValue: _selectedEmploymentType,
                hint: Text("Select Employment Type"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _employmentTypes
                    .map(
                      (value) =>
                          DropdownMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedEmploymentType = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              Center(
                child: FilledButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size(360, 54)),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    ref
                        .read(userProvider.notifier)
                        .addUser(
                          UserEntity(
                            id: Uuid().v4(),
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _mobileController.text,
                            country: _selectedCountry!,
                            monthlyIncome: double.parse(_incomeController.text),
                            empType: _selectedEmploymentType!,
                          ),
                        );

                    context.goNamed(AppRoutes.home);
                  },
                  child: Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
