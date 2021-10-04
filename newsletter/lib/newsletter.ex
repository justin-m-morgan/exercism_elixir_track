defmodule Newsletter do
  def read_emails(path) do
    {:ok, file} =
      File.open(path, [:read], fn file ->
        file
        |> IO.read(:all)
        |> String.split("\n")
        |> Enum.filter(&(String.length(&1) > 0))
      end)

    file
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    with pid <- open_log(log_path),
         email_list <- read_emails(emails_path) do
      Enum.each(email_list, fn email ->
        case send_fun.(email) do
          :ok -> log_sent_email(pid, email)
          _ -> nil
        end
      end)

      close_log(pid)
    end
  end
end
