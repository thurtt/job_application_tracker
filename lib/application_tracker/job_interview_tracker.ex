defmodule ApplicationTracker.JobInterviewTracker do
  @moduledoc """
  The JobInterviewTracker context.
  """

  import Ecto.Query, warn: false
  alias ApplicationTracker.Repo

  alias ApplicationTracker.JobInterviewTracker.Interview

  @doc """
  Returns the list of interviews.

  ## Examples

      iex> list_interviews()
      [%Interview{}, ...]

  """
  def list_interviews do
    Repo.all(Interview)
  end

  @doc """
  Gets a single interview.

  Raises `Ecto.NoResultsError` if the Interview does not exist.

  ## Examples

      iex> get_interview!(123)
      %Interview{}

      iex> get_interview!(456)
      ** (Ecto.NoResultsError)

  """
  def get_interview!(id), do: Repo.get!(Interview, id)

  @doc """
  Creates a interview.

  ## Examples

      iex> create_interview(%{field: value})
      {:ok, %Interview{}}

      iex> create_interview(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_interview(attrs \\ %{}) do
    %Interview{}
    |> Interview.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a interview.

  ## Examples

      iex> update_interview(interview, %{field: new_value})
      {:ok, %Interview{}}

      iex> update_interview(interview, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_interview(%Interview{} = interview, attrs) do
    interview
    |> Interview.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a interview.

  ## Examples

      iex> delete_interview(interview)
      {:ok, %Interview{}}

      iex> delete_interview(interview)
      {:error, %Ecto.Changeset{}}

  """
  def delete_interview(%Interview{} = interview) do
    Repo.delete(interview)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking interview changes.

  ## Examples

      iex> change_interview(interview)
      %Ecto.Changeset{data: %Interview{}}

  """
  def change_interview(%Interview{} = interview, attrs \\ %{}) do
    Interview.changeset(interview, attrs)
  end
end
