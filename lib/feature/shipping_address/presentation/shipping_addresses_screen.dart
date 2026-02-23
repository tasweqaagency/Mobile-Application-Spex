import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/widgets/app_button.dart';
import 'package:spex/feature/home/presentation/widgets/my_appbar.dart';
import 'package:spex/feature/shipping_address/model/address_model.dart';
import 'package:spex/feature/shipping_address/presentation/widgets/address_card.dart';
import 'package:spex/feature/shipping_address/presentation/widgets/address_dialog.dart';
import 'package:spex/generated/locale_keys.g.dart';
import 'package:spex/main.dart';

class ShippingAddressesScreen extends StatefulWidget {
  const ShippingAddressesScreen({super.key});

  @override
  State<ShippingAddressesScreen> createState() =>
      _ShippingAddressesScreenState();
}

class _ShippingAddressesScreenState extends State<ShippingAddressesScreen> {
  final List<AddressModel> _addresses = [
    AddressModel(
      id: "1",
      title: "Home",
      fullName: "Ahmed Mansour",
      streetAddress: "123 Tech Avenue, Silicon Heights",
      buildingApt: "Building 4, Apt 502",
      city: "Cairo, Egypt",
      phoneNumber: "+20 123 456 7890",
      isDefault: true,
    ),
    AddressModel(
      id: "2",
      title: "Office",
      fullName: "Ahmed Mansour",
      streetAddress: "Smart Village, Building B12",
      buildingApt: "SPEX Corporate Office, 2nd Floor",
      city: "Giza, Egypt",
      phoneNumber: "+20 111 222 3333",
      isDefault: false,
    ),
  ];

  String? _selectedAddressId = "1";

  void _addOrEditAddress([AddressModel? address]) {
    showDialog(
      context: context,
      builder: (context) => AddressDialog(
        address: address,
        onSave: (newAddress) {
          setState(() {
            if (address == null) {
              _addresses.add(newAddress);
            } else {
              final index = _addresses.indexWhere((a) => a.id == address.id);
              if (index != -1) {
                _addresses[index] = newAddress;
              }
            }
          });
        },
      ),
    );
  }

  void _deleteAddress(String id) {
    setState(() {
      _addresses.removeWhere((a) => a.id == id);
      if (_selectedAddressId == id) {
        _selectedAddressId = _addresses.isNotEmpty ? _addresses.first.id : null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.appBgColor
          : AppColorsLight.appBgColor,
      appBar: MyAppBarWithBackButton(
        title: LocaleKeys.address_shipping_addresses.tr(),
        showSearch: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              separatorBuilder: (context, index) => verticalSpace(16),
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return AddressCard(
                  address: address,
                  isSelected: _selectedAddressId == address.id,
                  onTap: () {
                    setState(() {
                      _selectedAddressId = address.id;
                    });
                  },
                  onEdit: () => _addOrEditAddress(address),
                  onDelete: () => _deleteAddress(address.id),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextButton(
              buttonText: LocaleKeys.address_add_new_address.tr(),
              backgroundColor: AppColorsLight.mainColor,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () => _addOrEditAddress(),
            ),
          ),
          verticalSpace(10.h),
        ],
      ),
    );
  }
}
