import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unibg_pokemon/presentation/pages/settings/theme_provider.dart';
import 'package:unibg_pokemon/presentation/styles/dimens.dart';
import 'package:unibg_pokemon/utils/utils.dart';

class PokemonThemeButton extends ConsumerWidget {
  const PokemonThemeButton({
    super.key,
    required this.isDark,
    required this.pokemonId,
  });

  final bool isDark;
  final int pokemonId;

  Color getBorderColor(Color acProvider, Brightness tProvider) {
    if (isDark) {
      return tProvider == Brightness.dark ? acProvider : Colors.transparent;
    } else {
      return tProvider == Brightness.light ? acProvider : Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acProvider = ref.watch(accentColorProvider);
    final tProvider = ref.watch(brightnessProvider);

    return InkWell(
      onTap: () => ref
          .read(brightnessProvider.notifier)
          .update((state) => isDark ? Brightness.dark : Brightness.light),
      child: Container(
        padding: const EdgeInsets.all(Dimens.smallPadding),
        width: getScreenWidth(context) * .45,
        decoration: BoxDecoration(
          border: Border.all(
            width: Dimens.mainBorderSideWidth,
            color: getBorderColor(acProvider, tProvider),
          ),
          borderRadius: BorderRadius.circular(Dimens.smallRoundedCorner),
        ),
        child: ExtendedImage.network(
          width: getScreenWidth(context) * .35,
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png",
        ),
      ),
    );
  }
}
