class ZTE < Oxidized::Model
  using Refinements

  comment '! '

  # Captura o prompt da OLT (ex: OLT-ZTE-Sao-Miguel#)
  prompt /^[\w\.-]+#\s?$/


  expect /^.*[M|m]ore.*$/ do |data, re|
    send " "
    data.sub re, ''
  end

  cmd :all do |cfg|
    cfg.gsub!(/\r/, '')
    cfg.gsub!(/\e\[[0-9;]*[A-Za-z]/, '') # Limpa caracteres de terminal/cores
    cfg
  end

  cmd 'show running-config' do |cfg|
    cfg
  end

  cfg :telnet, :ssh do
    post_login 'terminal length 0'
    pre_logout 'exit'
  end
end
