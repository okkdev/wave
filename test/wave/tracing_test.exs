defmodule Wave.TracingTest do
  use Wave.DataCase

  alias Wave.Tracing

  describe "contacts" do
    alias Wave.Tracing.Contact

    @valid_attrs %{city: "some city", firstname: "some firstname", lastname: "some lastname", phone: "some phone"}
    @update_attrs %{city: "some updated city", firstname: "some updated firstname", lastname: "some updated lastname", phone: "some updated phone"}
    @invalid_attrs %{city: nil, firstname: nil, lastname: nil, phone: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracing.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Tracing.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Tracing.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = Tracing.create_contact(@valid_attrs)
      assert contact.city == "some city"
      assert contact.firstname == "some firstname"
      assert contact.lastname == "some lastname"
      assert contact.phone == "some phone"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracing.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{} = contact} = Tracing.update_contact(contact, @update_attrs)
      assert contact.city == "some updated city"
      assert contact.firstname == "some updated firstname"
      assert contact.lastname == "some updated lastname"
      assert contact.phone == "some updated phone"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracing.update_contact(contact, @invalid_attrs)
      assert contact == Tracing.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Tracing.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Tracing.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Tracing.change_contact(contact)
    end
  end
end
