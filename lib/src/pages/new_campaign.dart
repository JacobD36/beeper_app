import 'package:beeper_app/src/providers/campaign_provider.dart';
import 'package:beeper_app/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/models/campaign_model.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:provider/provider.dart';


class NewCampaign extends StatefulWidget {
  static final String routeName = 'new_campaign';

  @override
  _NewCampaignState createState() => _NewCampaignState();
}

class _NewCampaignState extends State<NewCampaign> {
  final titleController = new TextEditingController();
  final descController = new TextEditingController();
  final respController = new TextEditingController();
  final phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    respController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final campaignForm = Provider.of<CampaignProvider>(context);

    return Scaffold(
      key: Environment.scaffoldKey,
      appBar: AppBar(
        title: Text('Nueva Campaña'),
      ),
      drawer: Drawer(
        child: MenuWidget()
      ),
      body: Stack(
        children: [
          BackDesign(),
          _formData(context, campaignForm)
        ]
      )
    );
  }

  Widget _formData(BuildContext context, CampaignProvider campaignForm) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7)
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0
        ),
        child: Form(
          key: campaignForm.formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Ingrese la información básica de la campaña a registrar', style: TextStyle(color: Colors.white, fontSize: 15.0)),
              ),
              SizedBox(height: 20.0),
              _titleInput(campaignForm),
              SizedBox(height: 10.0),
              _descInput(campaignForm),
              SizedBox(height: 10.0),
              _responsableInput(campaignForm),
              SizedBox(height: 10.0),
              _phoneInput(campaignForm),
              SizedBox(height: 20.0),
              Divider(color: Colors.white70),
              SizedBox(height: 10.0),
              _buttonList(context, campaignForm)
            ],
          )
        )
      ),
    );
  }

  Widget _titleInput(CampaignProvider campaignForm) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: titleController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre de la campaña',
        hintStyle: TextStyle(color: Colors.white38),
        labelText: 'Nombre',
        icon: Icon(Icons.ballot, color: Colors.white),
        labelStyle: new TextStyle(
          color: Colors.white
        ),
        //errorText: snapshot.error
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) => campaignForm.title = value,
      validator: (value) {
        return (value != null && value.length >= 3) ? null : 'Mínimo 3 caracteres';
      },
    );
  }

  Widget _descInput(CampaignProvider campaignForm) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: descController,
      maxLines: 3,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Descripción de la campaña',
        hintStyle: TextStyle(color: Colors.white38),
        labelText: 'Descripción',
        icon: Icon(Icons.speaker_notes, color: Colors.white),
        labelStyle: new TextStyle(
          color: Colors.white
        ),
        //errorText: snapshot.error
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) => campaignForm.desc = value,
      validator: (value) {
        return (value != null && value.length >= 20) ? null : 'Mínimo 20 caracteres';
      },
    );
  }

  Widget _responsableInput(CampaignProvider campaignForm) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: respController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Persona responsable de la campaña',
        hintStyle: TextStyle(color: Colors.white38),
        labelText: 'Nombre del responsable',
        icon: Icon(Icons.account_circle, color: Colors.white),
        labelStyle: new TextStyle(
          color: Colors.white
        ),
        //errorText: snapshot.error
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) => campaignForm.responsable = value,
      validator: (value) {
        return (value != null && value.length >= 3) ? null : 'Mínimo 3 caracteres';
      },
    );
  }

  Widget _phoneInput(CampaignProvider campaignForm) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: phoneController,
      enableInteractiveSelection: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Teléfono del responsable',
        hintStyle: TextStyle(color: Colors.white38),
        labelText: 'Teléfono',
        icon: Icon(Icons.phone, color: Colors.white),
        labelStyle: new TextStyle(
          color: Colors.white
        ),
        //errorText: snapshot.error
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) => campaignForm.phone = value,
      validator: (value) {
        return (value != null && value.length >= 8) ? null : 'Mínimo 8 caracteres';
      },
    );
  }

  /*_selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      locale: Locale('es','ES'),
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2018), 
      lastDate: new DateTime(2025)
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.day.toString() + '/' + picked.month.toString() + '/' + picked.year.toString();
      });
    }
  }*/

   _saveCampaign(BuildContext context, Campaign camp, CampaignProvider campaignForm) async {
    final campaignService = Provider.of<ConfigService>(context);

    campaignForm.isLoading = true;

    await campaignService.saveCampaign(camp);

    campaignForm.isLoading = false;
  }

  Widget _buttonList(BuildContext context, CampaignProvider campaignForm) {
    final Campaign campData = new Campaign();

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: campaignForm.isLoading ? Text('Espere') : Text('Grabar'),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: campaignForm.isLoading ? MaterialStateProperty.all(Colors.grey[600]) : MaterialStateProperty.all(Colors.blue[600]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
              ),
              onPressed: campaignForm.isLoading ? null : () {
                FocusScope.of(context).unfocus();

                if(!campaignForm.isValidForm()) return;

                campData.title = campaignForm.title;
                campData.desc = campaignForm.desc;
                campData.responsable = campaignForm.responsable;
                campData.phone = campaignForm.phone;

                _saveCampaign(context, campData, campaignForm);

                titleController.clear();
                descController.clear();
                respController.clear();
                phoneController.clear();

                Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'campaign');
                //Navigator.of(context).pop();
              }
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: Text('Cancelar'),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
              ),
              onPressed: () {
                titleController.clear();
                descController.clear();
                respController.clear();
                phoneController.clear();
                //Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'campaign');
                Navigator.of(context).pop();
              }
            )
          ],
        ),
      ),
    );
  }
}