import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_clone/stores/create_ad_store.dart';

import '../../components/custom_drawer/custom_drawer.dart';
import '../../theme/text_styles.dart';
import 'components/images_field.dart';

class CreateAdScreen extends StatelessWidget {
  CreateAdScreen({Key? key}) : super(key: key);

  final CreateAdStore createAdStore = CreateAdStore();

  @override
  Widget build(BuildContext context) {
    const _contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Criar anúncio'),
        centerTitle: true,
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesField(createAdStore: createAdStore),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: _contentPadding,
                labelText: 'Título *',
                labelStyle: TextStyles.textFormFieldLabel,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: _contentPadding,
                labelText: 'Descrição *',
                labelStyle: TextStyles.textFormFieldLabel,
              ),
              maxLines: null,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(),
              ],
              decoration: InputDecoration(
                contentPadding: _contentPadding,
                labelText: 'Preço *',
                labelStyle: TextStyles.textFormFieldLabel,
                prefixText: 'R\$ ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
