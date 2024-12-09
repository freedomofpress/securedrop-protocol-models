#!/usr/bin/env python3

from sys import argv, stdin, exit
import re

def splitter(line):
  splitted = line.split(':')
  return (splitted[0], splitted[1].strip())

lines = list(map(splitter, stdin.readlines()))
if not lines:
  exit(0)

def subToken(token, line):
  (num, goal) = line
  if isinstance(token, str):
    return num if token in goal else None
  else:
    return num if token.search(goal) is not None else None

def matchAgainstList(priorityList, lines):
  for token in priorityList:
    try:
      return next(filter(bool, map(lambda line: subToken(token, line), lines)))
    except StopIteration:
      pass

match = None
if argv[1] in ['Auto_Secrecy_Source_Message']:
  match = matchAgainstList([
    '!Ltk_Source_Passphrase( $S, ~passphrase )',
    '!Pk_Newsroom( $NR, pk(x)',
    '!KU( ~',
    '((∀ #x. (Reveal_Journalist_EDH_Key( je_dh_pk ) @ #x) ⇒ ⊥)',
    '!KU( aenc(<\'s_pk\', \'g\'^(~je_dh_sk',
    '!KU( aenc(<\'s_pk\', \'g\'^(~me_sk',
    '!KU( aenc(<\'s_pk\', \'g\'^~me_sk',
    '!KU( kdf(~ss) )',
    '!KU( \'g\'^(~je_dh_sk*~me_sk) )',
    '!KU( je_dh_pk^~me_sk )',
    '!KU( sign(<\'ephemeral',
    '!KU( kdf(<\'g\'^(~je_dh_sk*kdf(<\'DH\', ~passphrase>)),',
    '!KU( sign(<\'signature'
  ], lines)
elif argv[1] in ['Auto_Injective_Agreement_Source_Message']:
  match = matchAgainstList([
    '!KU( ~passphrase )',
    '!KU( ~je_dh_sk )',
    '!KU( ~me_sk )',
    '!KU( ~j_sig_sk )',
    '!KU( kdf(<\'DH\', ~passphrase>) )',
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(\~je_dh_sk'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(\~me_sk'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\~me_sk'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^x'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(x'),
    '!KU( kdf(<\'g\'^(~je_dh_sk*kdf(<\'DH\', ~passphrase>)),',
    '!KU( \'g\'^(~je_dh_sk*kdf(<\'DH\', ~passphrase>)) )',
    '!KU( sign(<\'ephemeral\', \'g\'^x',
    'Journalist_Ephemeral_Key( ',
    '!Ltk_Journalist_SIG_Key( $J.1, ~j_sig_sk )',
    '!Ltk_Journalist_SIG_Key',
    '!Journalist_Enrolled',
    '!KU( \'g\'^x )',
    '!KU( \'g\'^x.1',
    '(#x2',
    '!KU( senc(<\'msg_s2j\', ~msg,',
    '!KU( ~msg )',
    '!KU( kdf(<\'g\'^(~je_dh_sk*kdf(<\'DH\', ~passphrase>)),           \'g\'^(~je_dh_sk*~me_sk)>))',
    'splitEqs(3)'
  ], lines)
elif argv[1] in ['Auto_Secrecy_Journalist_Message']:
  match = matchAgainstList([
    '!KU( ~passphrase )',
    re.compile(r'!KU\( ~me_sk(\.\d+)? \)'),
    '!KU( kdf(<\'DH\', ~passphrase>) )',
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(\~je_dh_sk'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(\~me_sk'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\~me_sk'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^x'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(x'),
    '!Pk_Newsroom',
    '!KU( \'g\'^(~me_sk*kdf(<\'DH\', ~passphrase>)) )',
    '!Ltk_Source_Passphrase',
    '!KU( ~msg.1 )',
    '!KU( kdf(<\'g\'^(~j_dh_sk*kdf(<\'DH\', ~passphrase>)),           \'g\'^(~me_sk*kdf(<\'DH\', ~passphrase>)),',
  ], lines)
elif argv[1] in ['Auto_Non_Injective_Agreement_Journalist_Message']:
  match = matchAgainstList([
    '!KU( ~passphrase )',
    '!KU( ~x',
    '!KU( ~ltk',
    re.compile(r'!KU\( ~me_sk(\.\d+)? \)'),
    '!KU( kdf(<\'DH\', ~passphrase>) )',
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(\~je_dh_sk'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(\~x'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\~x'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^x'),
    re.compile(r'!KU\( aenc\(<\'s_pk\',\s*\'g\'\^\(x'),
    '!Pk_Newsroom',
    '!Ltk_Source_Passphrase',
    '!KU( kdf(<\'g\'^(~x*kdf(<\'DH\', ~passphrase>)), z, me_pk,',
    '!KU( senc(<\'msg_j2s\', ~msg, ',
    '!KU( sign(<\'signature\', j_sig_pk, \'g\'^~x>, ~ltk) )',
    '!KU( \'g\'^(~x*kdf(<\'DH\', ~passphrase>)) )'
  ], lines)
if match is not None:
  print(match)