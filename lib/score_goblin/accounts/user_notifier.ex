defmodule ScoreGoblin.Accounts.UserNotifier do
  import Swoosh.Email
  require Logger

  alias ScoreGoblin.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    Logger.info "Deliver called!"
    email =
      new()
      |> to(recipient)
      |> from({"ScoreGoblin", "scoregoblin@bigtoadsoftware.com"})
      |> subject(subject)
      |> text_body(body)

    Logger.info "trying to deliver"
    with {:ok, metadata} <- Mailer.deliver(email) do
      Logger.info "OK!"
      Logger.info metadata
      {:ok, email}
    else
      {:error, type, message} ->
        Logger.info "ERROR"
        Logger.info "type"
        Logger.info type
        Logger.info "message"
        Logger.info message
        {:error, type, message}
      {:error, reason} ->
        Logger.info "ERROR"
        Logger.info "reason"
        Logger.info((Kernel.inspect reason))
        {:error, reason}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(user.email, "Confirmation instructions", """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(user.email, "Reset password instructions", """

    ==============================

    Hi #{user.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, "Update email instructions", """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end
end
