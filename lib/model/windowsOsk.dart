import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

final _user32 = DynamicLibrary.open('user32.dll');
int _findWindowW(String nameClass, String? parent) {
  final _func = _user32.lookupFunction<
      IntPtr Function(Pointer<Utf16> nameClass, Pointer<Utf16> windowName),
      int Function(
          Pointer<Utf16> nameClass, Pointer<Utf16> windowName)>('FindWindowW');
  return _func(Pointer<Utf16>.fromAddress(nameClass.toNativeUtf16().address),
      Pointer<Utf16>.fromAddress(0));
}

int _postMessageA(int hWnd, int msg, int wParam, int lParam) {
  final _pm = _user32.lookupFunction<
      Int32 Function(IntPtr hWnd, Uint32 msg, IntPtr wParam, IntPtr lParam),
      int Function(int hWnd, int msg, int wParam, int lParam)>('PostMessageA');
  return _pm(hWnd, msg, wParam, lParam);
}

class WindowsOSK {
  static int _getTipBandPtr() {
    final shellTrayWnd = _findWindowW('Shell_TrayWnd', null);
    if (shellTrayWnd > 0) {
   
      final trayNotifWnd = FindWindowEx(
        shellTrayWnd,
        0,
        Pointer<Utf16>.fromAddress('TrayNotifyWnd'.toNativeUtf16().address),
        Pointer<Utf16>.fromAddress(0),
      );

      if (trayNotifWnd > 0) {
        final tipBand = FindWindowEx(
          trayNotifWnd,
          0,
          Pointer<Utf16>.fromAddress('TIPBand'.toNativeUtf16().address),
          Pointer<Utf16>.fromAddress(0),
        );


        if (tipBand > 0) {
          return tipBand;
        }
      }
    }

    return 0;
  }

  static void show() {
    final tipBand = _getTipBandPtr();
    if (tipBand > 0) {
      final closed = _postMessageA(tipBand, 513, 1, 65537);
      print(closed);

      final opened = _postMessageA(tipBand, 514, 1, 65537);
      print(opened);
    }
  }

  static void close() {
    final tipMainWnd = _findWindowW('IPTip_Main_Window', null);
    if (tipMainWnd > 0) {
      final res = SendMessage(tipMainWnd, 0x0112, 0xF060, 0);
      print(res);
    }
  }
}