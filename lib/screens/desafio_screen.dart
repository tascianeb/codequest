import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CriterioAvaliacao {
  final String titulo;
  final String descricao;
  final bool Function(String codigo) matcher;

  const CriterioAvaliacao({
    required this.titulo,
    required this.descricao,
    required this.matcher,
  });
}

class Desafio {
  final int nivel;
  final String unidade;
  final String titulo;
  final String enunciado;
  final String dica;
  final int xp;
  final String codigoInicial;
  final List<CriterioAvaliacao> criterios;

  const Desafio({
    required this.nivel,
    required this.unidade,
    required this.titulo,
    required this.enunciado,
    required this.dica,
    required this.xp,
    required this.codigoInicial,
    required this.criterios,
  });
}

final desafioSomaPares = Desafio(
  nivel: 6,
  unidade: 'Unidade 1 — Lógica',
  titulo: 'Soma dos pares',
  enunciado:
      'Escreva uma função somaPares que receba uma lista de inteiros e '
      'retorne a soma apenas dos valores pares.',
  dica: 'Percorra a lista e use o operador % para testar a paridade.',
  xp: 50,
  codigoInicial: 'int somaPares(List<int> numeros) {\n'
      '  // escreva sua solução aqui\n'
      '\n'
      '}',
  criterios: [
    CriterioAvaliacao(
      titulo: 'Usa um laço de repetição',
      descricao: 'Percorre todos os itens da lista',
      matcher: (c) =>
          RegExp(r'\b(for|while)\b').hasMatch(c) ||
          RegExp(r'\.forEach\b').hasMatch(c),
    ),
    CriterioAvaliacao(
      titulo: 'Verifica a paridade corretamente',
      descricao: 'Identifica números pares com %',
      matcher: (c) => RegExp(r'%\s*2\s*==\s*0').hasMatch(c),
    ),
    CriterioAvaliacao(
      titulo: 'Retorna um valor inteiro',
      descricao: 'A função devolve a soma acumulada',
      matcher: (c) => RegExp(r'\breturn\b').hasMatch(c),
    ),
  ],
);

class DesafioScreen extends StatefulWidget {
  final Desafio desafio;

  final VoidCallback? onConcluido;

  const DesafioScreen({
    super.key,
    required this.desafio,
    this.onConcluido,
  });

  @override
  State<DesafioScreen> createState() => _DesafioScreenState();
}

class _DesafioScreenState extends State<DesafioScreen> {
  late final TextEditingController _codeCtrl;
  Map<int, bool> _resultado = {};
  bool _avaliando = false;
  bool _avaliado = false;

  static const _bg = Color(0xFF0F0A1F);
  static const _surface = Color(0xFF1B1233);
  static const _surface2 = Color(0xFF241845);
  static const _line = Color(0xFF36275E);
  static const _violet = Color(0xFF7C4DFF);
  static const _violetSoft = Color(0xFFA181FF);
  static const _gold = Color(0xFFFFCA5F);
  static const _green = Color(0xFF3DDC84);
  static const _red = Color(0xFFFF5D73);
  static const _ink = Color(0xFFEDE8FF);
  static const _muted = Color(0xFF9D92C4);
  static const _codeBg = Color(0xFF150D2B);

  @override
  void initState() {
    super.initState();
    _codeCtrl = TextEditingController(text: widget.desafio.codigoInicial);
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  String _normalizar(String src) =>
      src.replaceAll(RegExp(r'//.*'), '');

  Future<void> _executar() async {
    setState(() => _avaliando = true);
    await Future.delayed(const Duration(milliseconds: 700));

    final codigo = _normalizar(_codeCtrl.text);
    final res = <int, bool>{};
    for (var i = 0; i < widget.desafio.criterios.length; i++) {
      res[i] = widget.desafio.criterios[i].matcher(codigo);
    }

    setState(() {
      _resultado = res;
      _avaliando = false;
      _avaliado = true;
    });

    final concluido = res.values.every((ok) => ok);
    if (concluido) widget.onConcluido?.call();
  }

  int get _acertos => _resultado.values.where((ok) => ok).length;
  bool get _concluido =>
      _avaliado && _acertos == widget.desafio.criterios.length;

  @override
  Widget build(BuildContext context) {
    final d = widget.desafio;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(d),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _eyebrow('⚔️  DESAFIO'),
                    _problema(d),
                    _label('SEU CÓDIGO'),
                    _editor(),
                    _label('CRITÉRIOS DE AVALIAÇÃO'),
                    _criterios(d),
                    if (_avaliado) _feedback(d),
                  ],
                ),
              ),
            ),
            _footer(d),
          ],
        ),
      ),
    );
  }

  Widget _header(Desafio d) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
        child: Row(
          children: [
            _iconButton(Icons.arrow_back, 'Voltar ao mapa',
                () => Navigator.of(context).maybePop()),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: 0.62,
                      minHeight: 8,
                      backgroundColor: _surface2,
                      valueColor:
                          const AlwaysStoppedAnimation(_violetSoft),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('NÍVEL ${d.nivel} · ${d.unidade.toUpperCase()}',
                      style: const TextStyle(
                          fontSize: 10,
                          letterSpacing: 1,
                          color: _muted)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _gold.withOpacity(.12),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: _gold.withOpacity(.3)),
              ),
              child: Text('⚡ ${d.xp} XP',
                  style: const TextStyle(
                      color: _gold,
                      fontWeight: FontWeight.w800,
                      fontSize: 12)),
            ),
          ],
        ),
      );

  Widget _iconButton(IconData icon, String tooltip, VoidCallback onTap) =>
      Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _surface2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _line),
            ),
            child: Icon(icon, color: _ink, size: 20),
          ),
        ),
      );

  Widget _eyebrow(String t) => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 6),
        child: Text(t,
            style: const TextStyle(
                fontSize: 11,
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
                color: _violetSoft)),
      );

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 22, bottom: 8),
        child: Text(t,
            style: const TextStyle(
                fontSize: 11,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
                color: _muted)),
      );

  Widget _problema(Desafio d) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _surface2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(d.titulo,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _ink)),
            const SizedBox(height: 8),
            Text(d.enunciado,
                style: const TextStyle(
                    fontSize: 14, height: 1.55, color: _muted)),
            const SizedBox(height: 10),
            Text('💡 ${d.dica}',
                style: const TextStyle(fontSize: 12.5, color: _violetSoft)),
          ],
        ),
      );

  Widget _editor() => Container(
        decoration: BoxDecoration(
          color: _codeBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _line),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _violet.withOpacity(.06),
                border: const Border(bottom: BorderSide(color: _line)),
              ),
              child: Row(
                children: [
                  const Text('🧩 solucao.dart',
                      style: TextStyle(
                          color: _violetSoft,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: _line),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Dart',
                        style: TextStyle(color: _muted, fontSize: 10)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: TextField(
                controller: _codeCtrl,
                maxLines: null,
                minLines: 6,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  height: 1.6,
                  color: Color(0xFFC3E88D),
                ),
                cursorColor: _violetSoft,
                decoration: const InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: 'Digite seu código Dart…',
                  hintStyle: TextStyle(color: Color(0xFF5C6685)),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _criterios(Desafio d) => Container(
        decoration: BoxDecoration(
          color: _surface2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _line),
        ),
        child: Column(
          children: List.generate(d.criterios.length, (i) {
            final c = d.criterios[i];
            final ok = _resultado[i];
            Color boxColor = _line;
            Widget mark = const SizedBox.shrink();
            if (ok == true) {
              boxColor = _green;
              mark = const Icon(Icons.check, size: 14, color: Color(0xFF06351C));
            } else if (ok == false) {
              boxColor = _red;
              mark = const Icon(Icons.close, size: 14, color: Color(0xFF3A0510));
            }
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                border: i == 0
                    ? null
                    : const Border(top: BorderSide(color: _line)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    margin: const EdgeInsets.only(top: 1),
                    decoration: BoxDecoration(
                      color: ok == null ? Colors.transparent : boxColor,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: boxColor, width: 2),
                    ),
                    child: mark,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.titulo,
                            style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: _ink)),
                        Text(c.descricao,
                            style: const TextStyle(
                                fontSize: 12, color: _muted)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );

  Widget _feedback(Desafio d) {
    final ok = _concluido;
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (ok ? _green : _red).withOpacity(.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ok ? _green : _red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ok
                ? '✓ Desafio concluído!'
                : 'Quase lá — $_acertos/${d.criterios.length} critérios',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: ok ? const Color(0xFFBFF7D4) : const Color(0xFFFFC2CC)),
          ),
          const SizedBox(height: 3),
          Text(
            ok
                ? 'Todos os critérios foram atendidos. +${d.xp} XP creditados e Unidade 2 desbloqueada.'
                : 'Revise os itens em vermelho e execute novamente.',
            style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: ok ? const Color(0xFFBFF7D4) : const Color(0xFFFFC2CC)),
          ),
        ],
      ),
    );
  }

  Widget _footer(Desafio d) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: const BoxDecoration(
          color: Color(0x2E000000),
          border: Border(top: BorderSide(color: _line)),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _avaliando ? null : _executar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _violet,
                  disabledBackgroundColor: _violet.withOpacity(.55),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  _avaliando ? 'Avaliando…' : '▶  Executar código',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Conclua os ${d.criterios.length} critérios para ganhar +${d.xp} XP e desbloquear a Unidade 2',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: _muted),
            ),
          ],
        ),
      );
}

class ChallengeNode extends StatelessWidget {
  final Desafio desafio;
  final VoidCallback? onConcluido;

  const ChallengeNode({
    super.key,
    required this.desafio,
    this.onConcluido,
  });

  void _abrirDesafio(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DesafioScreen(
          desafio: desafio,
          onConcluido: onConcluido,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir Desafio ${desafio.nivel}',
      child: InkWell(
        onTap: () => _abrirDesafio(context),
        customBorder: const CircleBorder(),
        child: Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7C4DFF), Color(0xFF5A32C4)],
            ),
            border: Border.all(color: const Color(0xFFA181FF), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withOpacity(.45),
                blurRadius: 0,
                spreadRadius: 6,
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('⚔️', style: TextStyle(fontSize: 20)),
              SizedBox(height: 2),
              Text('DESAFIO',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: .5)),
            ],
          ),
        ),
      ),
    );
  }
}
