import 'package:flutter/material.dart';

// como o header tem varias funções, preferi separar para organizar melhor
// - verificar a base de dados para ver se o utilizador tem mensagens recebidas e nao abertas
// - foto de perfil do utilizador
// Sempre que usarem o header terão que implementar duas funções de callback para tratar destes dois casos (podem copiar do home.dart)
Widget Header(String username, VoidCallback onProfilePressed,VoidCallback onMessagesPressed) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 20, 20, 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipOval(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 2, 180,0),
            child: Image.asset(
              'assets/icons/icon.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${username}",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFFA0A0A0),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.email_outlined,
                    size: 30.0,
                    color: Color(0xFFA0A0A0),
                  ),
                  onPressed: onMessagesPressed,
                ),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: onProfilePressed,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/id/29/200',
                    ),
                    radius: 25.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}