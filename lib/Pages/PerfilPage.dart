import 'package:detranapp/models/App_User.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Importação do pacote para capturar imagens
import 'package:provider/provider.dart';
import 'dart:io';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late TextEditingController _nomeController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _cpfController = TextEditingController();
  late TextEditingController _datanascimentoController =
      TextEditingController();

  bool _isEditing = false;
  bool _userIsNull = false;
  DateTime? _selectedDate;
  XFile? _profileImage; // Variável para armazenar a imagem do perfil

  final ImagePicker _picker = ImagePicker(); // Instância do ImagePicker

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    App_User? user = await Provider.of<UserProvider>(context, listen: false)
        .getUserDataFromDatabase();

    if (user == null) {
      setState(() {
        _userIsNull = true;
      });
    } else {
      setState(() {
        _selectedDate = user.datanascimento;
        _nomeController = TextEditingController(text: user.nome);
        _phoneController = TextEditingController(text: user.phone_number);
        _cpfController = TextEditingController(text: user.cpf);
        _datanascimentoController = TextEditingController(
          text:
              "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
        );
        // Atribuição da imagem do perfil se existir
        _profileImage = user
            .profileImage; // Assumindo que a classe App_User tenha o campo profileImage
      });
    }
  }

  @override
  void dispose() {
    if (!_userIsNull) {
      _nomeController.dispose();
      _phoneController.dispose();
      _cpfController.dispose();
      _datanascimentoController.dispose();
    }
    super.dispose();
  }

  InputDecoration getTextFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 0, 128, 198),
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          color: Color.fromRGBO(7, 44, 252, 1),
        ),
      ),
    );
  }

  // Método para escolher a foto do perfil
  Future<void> _chooseProfileImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Galeria de imagens
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    }
  }

  // Método para tirar uma nova foto do perfil com a câmera
  Future<void> _takeProfilePhoto() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera, // Câmera
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoggedIn == false) {
      _userIsNull = true;
    }

    if (_userIsNull) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 80,
              color: Colors.black54,
            ),
            const SizedBox(height: 16),
            const Text(
              'É necessário fazer login para acessar o perfil do usuário.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 128, 198),
        automaticallyImplyLeading: false, // Remover o ícone de voltar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Exibição da foto do perfil
              GestureDetector(
                  onTap: () {
                    // Exibe opções de galeria ou câmera
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Escolher Foto'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _chooseProfileImage();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Galeria'),
                            ),
                            TextButton(
                              onPressed: () {
                                _takeProfilePhoto();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Câmera'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _profileImage != null
                        ? FileImage(File(
                            _profileImage!.path)) // Converte de XFile para File
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  )),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('Nome'),
                enabled: _isEditing,
              ),
              TextFormField(
                controller: _phoneController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('Telefone'),
                enabled: _isEditing,
              ),
              TextFormField(
                controller: _cpfController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('CPF'),
                enabled: _isEditing,
              ),
              TextFormField(
                controller: _datanascimentoController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('Data de Nascimento'),
                enabled: _isEditing,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    locale: const Locale('pt', 'BR'),
                  );

                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                      _datanascimentoController.text =
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 128, 198),
                      ),
                      onPressed: () async {
                        if (_isEditing) {
                          App_User? user =
                              await userProvider.getUserDataFromDatabase();

                          if (user != null) {
                            final updatedUser = App_User(
                              id: user.id,
                              nome: _nomeController.text,
                              phone_number: _phoneController.text,
                              cpf: _cpfController.text,
                              datanascimento: _selectedDate!,
                              email: user.email,
                              profileImage:
                                  _profileImage, // Atualiza a imagem do perfil
                            );

                            await userProvider.updateUserInFirebase(
                                updatedUser, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Erro: Usuário não encontrado.')),
                            );
                          }
                        }

                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                      child: Text(
                        _isEditing ? 'Salvar' : 'Editar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Deletar',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 168, 8, 8),
                    ),
                    onPressed: () async {
                      try {
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);

                        // Obtenha o ID do usuário atual
                        final user = userProvider.currentUser;
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Nenhum usuário logado.')),
                          );
                          return;
                        }

                        // Deletar do Firebase Authentication
                        await userProvider.deleteCurrentUser();

                        App_User? userdelete =
                            await userProvider.getUserDataFromDatabase();

                        if (userdelete != null) {
                          final userId = userdelete.id;

                          // Deletar do Firebase Realtime Database
                          final databaseReference =
                              FirebaseDatabase.instance.ref('users/$userId');
                          await databaseReference.remove();
                          userProvider.logout();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Usuário deletado com sucesso!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Erro ao deletar usuário: $e')),
                        );
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
