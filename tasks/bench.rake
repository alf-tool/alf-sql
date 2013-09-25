namespace :bench do

  task :summary do
    cmd = "bundle exec ruby -Ilib -I spec/integration/ spec/integration/bench_all.rb"
    cmd << " | "
    cmd << "alf --ff=%.6f --input-reader=rash summarize -- file -- min 'min{ total }' max 'max{ total }' stddev 'stddev{ total }'"
    puts cmd
    exec(cmd)
  end

  task :rank do
    cmd = "bundle exec ruby -Ilib -I spec/integration/ spec/integration/bench_all.rb"
    cmd << " | "
    cmd << "alf --input-reader=rash rank -- total desc -- position"
    cmd << " | "
    cmd << "alf --input-reader=rash project -- position file query parsing compiling printing total"
    cmd << " | "
    cmd << "alf --ff=%.6f --input-reader=rash restrict -- 'position < 10'"
    puts cmd
    exec(cmd)
  end

end