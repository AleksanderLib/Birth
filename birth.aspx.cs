using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Net;
using System.IO;
using System.Xml.Linq;
using System.Data;
using System.Windows.Forms;
using System.Text;
using System.Web.Configuration;
using System.Data.SqlClient;
namespace MonitoringDeath
{
    public partial class birth : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(WebConfigurationManager.AppSettings["ForceReload"]))
            {
                if (WebConfigurationManager.AppSettings["ForceReload"] == "true")
                {
                    Response.Redirect("ForceReload.aspx");
                }
            }
            if (Request.Cookies["UserName"] == null || Request.Cookies["Password"] == null)
            {
                Response.Redirect("Main.aspx");
            }
            else
            {
                string Prov1 = Request.Cookies["UserName"].Value.ToString();
                string Prov2 = Request.Cookies["Password"].Value.ToString();
                string Prov3 = Request.Cookies["NameInterface"].Value.ToString();
                if (string.IsNullOrEmpty(Prov1) && string.IsNullOrEmpty(Prov2) && string.IsNullOrEmpty(Prov3))
                {
                    Response.Redirect("Main.aspx");
                }
                else
                {
                    string UsName = Request.Cookies["UserName"].Value;
                    string Pass = Request.Cookies["Password"].Value;
                    string RoleInterface = Request.Cookies["NameInterface"].Value.ToString();
                    string id_Auth = Request.Cookies["id_Auth"].Value.ToString();
                    byte[] bUsName = Convert.FromBase64String(UsName);
                    byte[] bPass = Convert.FromBase64String(Pass);
                    UsName = Encoding.UTF8.GetString(bUsName).ToString();
                    Pass = Encoding.UTF8.GetString(bPass).ToString();

                    //Получение информации о пользователе по id_Auth
                    if (!X.IsAjaxRequest)
                    {
                        string ConnStr = WebConfigurationManager.AppSettings["DemosDB"];
                        SqlConnection Conn = new SqlConnection(ConnStr);
                        Conn.Open();
                        SqlCommand cmd = new SqlCommand("GetDataDoctor", Conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@id_Auth", id_Auth);
                        cmd.Parameters.Add("@FamilyDoctor", SqlDbType.VarChar, 50);
                        cmd.Parameters["@FamilyDoctor"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@NameDoctor", SqlDbType.VarChar, 50);
                        cmd.Parameters["@NameDoctor"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@FatherNameDoctor", SqlDbType.VarChar, 50);
                        cmd.Parameters["@FatherNameDoctor"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@PostDoctor", SqlDbType.VarChar, 100);
                        cmd.Parameters["@PostDoctor"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@NameLPU", SqlDbType.VarChar, 200);
                        cmd.Parameters["@NameLPU"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@AddressLPU", SqlDbType.VarChar, 200);
                        cmd.Parameters["@AddressLPU"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@CodOKPO", SqlDbType.Int);
                        cmd.Parameters["@CodOKPO"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@CodOKUD", SqlDbType.Int);
                        cmd.Parameters["@CodOKUD"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@FamilyHeadLPU", SqlDbType.VarChar, 50);
                        cmd.Parameters["@FamilyHeadLPU"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@NameHeadLPU", SqlDbType.VarChar, 50);
                        cmd.Parameters["@NameHeadLPU"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@FatherNameHeadLPU", SqlDbType.VarChar, 50);
                        cmd.Parameters["@FatherNameHeadLPU"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@id_Doctor", SqlDbType.Int);
                        cmd.Parameters["@id_Doctor"].Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();
                        Conn.Close();
                        id_Doctor.Text = cmd.Parameters["@id_Doctor"].Value.ToString();
                        //реквизиты врача заполнявшего документ
                        FIO_Doctor.Text = cmd.Parameters["@FamilyDoctor"].Value.ToString() + " " + cmd.Parameters["@NameDoctor"].Value.ToString() + " " + cmd.Parameters["@FatherNameDoctor"].Value.ToString();
                        Post_Doctor.Text = cmd.Parameters["@PostDoctor"].Value.ToString();

                        //реквизиты руководителя медицинско организации
                        txfHead_1.Text = cmd.Parameters["@FamilyHeadLPU"].Value.ToString();
                        txfHead_2.Text = cmd.Parameters["@NameHeadLPU"].Value.ToString();
                        txfHead_3.Text = cmd.Parameters["@FatherNameHeadLPU"].Value.ToString();


                        DateSv.MaxDate = DateTime.Now;
                        DateSv.Text = Convert.ToDateTime(DateTime.Now).ToShortDateString();

                        dfFullDate.MaxDate = DateTime.Now;
                        MotherBirthDay.MaxDate = DateTime.Now;
                        DateGotSv.MaxDate = DateTime.Now;
                        DateGotSv.Text = Convert.ToDateTime(DateTime.Now).ToShortDateString();

                        if (BirthOccurred_1.Checked == true)
                        {
                            BirthOccurred_LPU.Hidden = false;
                            string ConnStr1 = WebConfigurationManager.AppSettings["DemosDB"];
                            SqlConnection Conn1 = new SqlConnection(ConnStr1);
                            Conn1.Open();
                            SqlCommand cmd1 = new SqlCommand("GetBirthOccurredLPU", Conn1);
                            cmd1.CommandType = CommandType.StoredProcedure;
                            cmd1.Parameters.Clear();
                            DataSet ds1 = new DataSet("records");
                            SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                            da1.Fill(ds1);
                            strBirthOccurred_LPU.DataSource = ds1;
                            strBirthOccurred_LPU.DataBind();
                            cmd1.ExecuteNonQuery();
                            Conn1.Close();
                        }
                        else
                        {
                            BirthOccurred_LPU.Hidden = true;
                        }


                    }
                    //DateAndDied.MinDate = DateBornLive.SelectedDate;
                }
            }
        }

        //Проверка номера свидетельства
        protected void activF(object sender, DirectEventArgs e)
        {
            try
            {
                string ConnStr = WebConfigurationManager.AppSettings["DemosDB"];
                SqlConnection Conn = new SqlConnection(ConnStr);
                Conn.Open();
                SqlCommand cmd = new SqlCommand("ProvBirthKidbyNumberSv", Conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@NumberSv", NumberSv.Text);
                DataSet ds = new DataSet("records");
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                cmd.ExecuteNonQuery();
                Conn.Close();
                string prov = ds.Tables[0].Rows[0]["NumberSv"].ToString();
                ProvNumber.Text = "NO";
            }
            catch
            {
                ProvNumber.Text = "OK";
            }
            if (ProvNumber.Text == "NO")
            {
                X.Msg.Alert("Внимание", "Данный номер уже использован.<br> Введите пожалуйста другой номер!").Show();
                NumberSv.Clear();
            }
        }

        //Кнопка назад
        protected void Back_Click(object sender, DirectEventArgs e)
        {
            X.Msg.Confirm("Внимание", "Если данные небыли сохранены, то вся введённая информация будет стёрта", new MessageBoxButtonsConfig
            {
                Yes = new MessageBoxButtonConfig
                {
                    Handler = "history.back();",
                    Text = "Да, выйти"
                },
                No = new MessageBoxButtonConfig
                {
                    Text = "Нет"
                }
            }).Show();
        }
        //Выбор вида свидетельства
       
        //Подгрузка предыдущего свидетельства

        protected void cmbBirth_change(object sender, DirectEventArgs e)
        {
            if (cmbBirth.Value.ToString() == "FullDate")
            {
                dfFullDate.Disabled = false;
                nbfYearDate.Disabled = true;
                cmbMonthDate.Disabled = true;
                cmbMonthDate.Text = "XX";
                txfFullDate.Clear();
            }
            if (cmbBirth.Value.ToString() == "YearDate")
            {
                nbfYearDate.Disabled = false;
                dfFullDate.Disabled = true;
                cmbMonthDate.Disabled = true;
                cmbMonthDate.Text = "XX";
                txfFullDate.Clear();
            }
            if (cmbBirth.Value.ToString() == "YaMDate")
            {
                nbfYearDate.Disabled = false;
                cmbMonthDate.Disabled = false;
                dfFullDate.Disabled = true;
                cmbMonthDate.Text = "XX";
                txfFullDate.Clear();
            }
            if (cmbBirth.Value.ToString() == "NoDate")
            {
                nbfYearDate.Disabled = true;
                dfFullDate.Disabled = true;
                cmbMonthDate.Disabled = true;
                cmbMonthDate.Text = "XX";
                txfFullDate.Text = "XX.XX.XXXX";
            }
        }

        protected void dfFullDate_select(object sender, DirectEventArgs e)
        {
            txfFullDate.Text = Convert.ToDateTime(dfFullDate.Text).ToShortDateString();            
        }

        protected void nbfYearDate_changed(object sender, DirectEventArgs e)
        {
            if (nbfYearDate.Text.Length < 4)
            {

                X.Msg.Notify("Внимание", "Не допустимый формат года. Год вводится в формате ГГГГ").Show();
            }
            else
            {
                txfFullDate.Text = "XX." + cmbMonthDate.Value.ToString() + "." + nbfYearDate.Value.ToString();
            }
        }

        protected void cmbMonthDate_select(object sender, DirectEventArgs e)
        {
            if (nbfYearDate.Text.Length < 4)
            {
                X.Msg.Notify("Внимание", "Выберите год").Show();
                nbfYearDate.Focus();
            }
            else
            {
                txfFullDate.Text = "XX." + cmbMonthDate.Value.ToString() + "." + nbfYearDate.Value.ToString();

            }
        }

        //Справочник ЛПУ для пунка 10 - в стационаре
        protected void BirthOccurred_1_Check(object sender, DirectEventArgs e)
        {
            if (BirthOccurred_1.Checked == true)
            {
                BirthOccurred_LPU.Hidden = false;
                string ConnStr = WebConfigurationManager.AppSettings["DemosDB"];
                SqlConnection Conn = new SqlConnection(ConnStr);
                Conn.Open();
                SqlCommand cmd = new SqlCommand("GetBirthOccurredLPU", Conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                DataSet ds = new DataSet("records");
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                strBirthOccurred_LPU.DataSource = ds;
                strBirthOccurred_LPU.DataBind();
                cmd.ExecuteNonQuery();
                Conn.Close();
            }
            else
            {
                BirthOccurred_LPU.Hidden = true;
            }
        }

        protected void VidBirth_Check(object sender, DirectEventArgs e)
        {
            if (chbStillBirth_1.Checked)
            {
                nbfStillBirth_2.Disabled = true;
                nbfStillBirth_3.Disabled = true;
            }
            else
            {
                nbfStillBirth_2.Disabled = false;
                nbfStillBirth_3.Disabled = false;
            }
        }

        //ВЫБОР ОБРАЗОВАНИЯ
        protected void Education_Check(object sender, DirectEventArgs e)
        {
            if (rEducation_1.Checked)
            {
                cmbEducation_1.Disabled = false;
                cmbEducation_2.Disabled = true;
            }
            if (rEducation_2.Checked)
            {
                cmbEducation_1.Disabled = true;
                cmbEducation_2.Disabled = false;
            }
            if (rEducation_3.Checked)
            {
                cmbEducation_1.Disabled = true;
                cmbEducation_2.Disabled = true;
            }
        }

        //ЗАНЯТОСТЬ
        protected void Work_Check(object sender, DirectEventArgs e)
        {
            if (rWork_1.Checked)
            {
                cmbWork_1.Disabled = false;
                cmbWork_2.Disabled = true;
            }
            if (rWork_2.Checked)
            {
                cmbWork_1.Disabled = true;
                cmbWork_2.Disabled = false;
            }
            if (rWork_3.Checked)
            {
                cmbWork_1.Disabled = true;
                cmbWork_2.Disabled = true;
            }
        }

        
       
        //Кнопка сохранения свидетельства
        protected void btnSaveExtract_click(object sender, DirectEventArgs e)
        {
            int metka = 0;
            string s = "<br>Не введены следующие поля: <br>";

            try
            {
                string ConnStr = WebConfigurationManager.AppSettings["DemosDB"];
                SqlConnection Conn = new SqlConnection(ConnStr);
                Conn.Open();
                SqlCommand cmd = new SqlCommand();

                cmd = new SqlCommand("SaveSvBirth", Conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                
                //ФАМИЛИЯ РЕБЁНКА
                //if (string.IsNullOrEmpty(txfKidFamily.Text))
                //{
                //    s = s + "Фамилия<br> ";
                //}
                //else
                //{
                cmd.Parameters.AddWithValue("@FamilyKid", txfKidFamily.Text);//ФАМИЛИЯ
                //}
                if (string.IsNullOrEmpty(txfFullDate.Text))
                {
                    s = s + "Дата рождения ребёнка<br> ";
                    txfFullDate.MarkInvalid();
                }
                else
                {
                    cmd.Parameters.AddWithValue("@BirthDayKid", txfFullDate.Text);//дата рождения
                }
                cmd.Parameters.AddWithValue("@BirthTimeKid", TimeBirth.Text);//дата рождения
                //ПОЛ РЕБЁНКА
                if (SexMale.Checked)//если женский
                {
                    cmd.Parameters.AddWithValue("@id_Sex", 1);//записываем 1-мальчик
                }
                if (SexFemale.Checked)//если мужской
                {
                    cmd.Parameters.AddWithValue("@id_Sex", 2);//записываем 2-девочка
                }
                if (!SexMale.Checked && !SexFemale.Checked)
                {
                    s = s + "Пол ребёнка<br> ";
                    SexFemale.MarkInvalid();
                    SexMale.MarkInvalid();
                }
                
                //МЕСТО рождения
                if (string.IsNullOrEmpty(AoidBirth.Text))
                {
                    s = s + "Место рождения ребёнка<br> ";
                    AoidBirth.MarkInvalid();
                }
                else
                {
                    cmd.Parameters.AddWithValue("@AoidBirth", AoidBirth.Text);//место проживания
                }
                cmd.Parameters.AddWithValue("@AoidAOBirth", aoidAOBirth.Text);
                //МЕСТНОСТЬ РОждения
                if (LocationBirth_1.Checked)//если выбрана городская
                {
                    cmd.Parameters.AddWithValue("@LocationBirth", 1);//запичывается  1
                }
                if (LocationBirth_2.Checked)//если выбрана сельская
                {
                    cmd.Parameters.AddWithValue("@LocationBirth", 2);//записывается 2
                }
                if (LocationBirth_3.Checked)//если выбрана неизвестно
                {
                    cmd.Parameters.AddWithValue("@LocationBirth", 3);//записывается 2
                }
                if (!LocationBirth_1.Checked && !LocationBirth_2.Checked && !LocationBirth_3.Checked)
                {
                    s = s + "Местность рождения ребёнка<br>";
                    LocationBirth_1.MarkInvalid();
                    LocationBirth_2.MarkInvalid();
                    LocationBirth_3.MarkInvalid();
                }
                //ВЕС РЕБЁНКА(ПЛОДА)
                if (nbfWeightKid.Text=="1")
                {
                    s = s + "Масса тела ребёнка<br>";
                    nbfWeightKid.MarkInvalid();
                }
                else
                {
                    cmd.Parameters.AddWithValue("@KidWeight", Convert.ToInt32(nbfWeightKid.Value.ToString()));
                }
                //ДЛИНА ТЕЛА РЕБЁНКА(ПЛОДА)
                if (nbfLengthKid.Text=="1")
                {
                    s = s + "Длина тела ребёнка<br>";
                    nbfLengthKid.MarkInvalid();
                }
                else
                {
                    cmd.Parameters.AddWithValue("@kidLength", Convert.ToInt32(nbfLengthKid.Value.ToString()));
                }
                //ФАМИЛИЯ МАТЕРИ
                //if (string.IsNullOrEmpty(txfMotherFamily.Text))
                //{
                //    s = s + "Фамилия матери<br> ";
                //}
                //else
                //{
                cmd.Parameters.AddWithValue("@FamilyMother", txfMotherFamily.Text);//ФАМИЛИЯ
                //}
                //ИМЯ МАТЕРИ
                //if (string.IsNullOrEmpty(txfMotherName.Text))
                //{
                //    s = s + "Имя матери<br> ";
                //}
                //else
                //{
                cmd.Parameters.AddWithValue("@NameMother", txfMotherName.Text);//ИМЯ
                //}
                //ОТЧЕСТВО МАТЕРИ
                if (string.IsNullOrEmpty(txfMotherFatherName.Text))
                {
                    cmd.Parameters.AddWithValue("@FatherNameMother", "НЕТ");
                }
                else
                {
                    cmd.Parameters.AddWithValue("@FatherNameMother", txfMotherFatherName.Text);//ОТЧЕСТВО
                }
                //ДАТА РОЖДЕНИЯ МАТЕРИ
                //if (MotherBirthDay.Text == "01.01.0001 0:00:00")
                //{
                //    s = s + "Дата рождения матери<br> ";
                //}
                //else
                //{
                    cmd.Parameters.AddWithValue("@BirthDayMother", Convert.ToDateTime(MotherBirthDay.SelectedDate).ToShortDateString());//ДАТА РОЖДЕНИЯ МАТЕРИ
                //}
                //МЕСТО ПРОЖИВАНИЯ МАТЕРИ


                if (ifAlien.Checked)
                {                                            
                    cmd.Parameters.AddWithValue("@AoidLife", txfRegionAlien.Text + " " + txfAreaAlien.Text + " " + txfCityAlien.Text + " " + txfTownAlien.Text);//место проживания
                        
                    if (string.IsNullOrEmpty(txfStreetAlien.Text))
                    {
                        cmd.Parameters.AddWithValue("@LifeStreet", null);//улица иностранца
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@LifeStreet", txfStreetAlien.Text);
                    }
                    if (string.IsNullOrEmpty(txfHouseAlien.Text))//дом иностранца
                    {
                        cmd.Parameters.AddWithValue("@LifeHouse", null);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@LifeHouse", txfHouseAlien.Text);
                    }
                    cmd.Parameters.AddWithValue("@LifeRoom", txfRoomAlien.Text);//квартира проживания
                }
                else
                {
                    //if (string.IsNullOrEmpty(aoidLife.Text))
                    //{
                    //    s = s + "Место проживания матери<br> ";
                    //}
                    //else
                    //{
                    cmd.Parameters.AddWithValue("@AoidLife", aoidLife.Text);//место проживания

                    //}
                    if (string.IsNullOrEmpty(cmbAreaLife.Text) && !string.IsNullOrEmpty(cmbCityLife.Text))
                    {
                        //if (string.IsNullOrEmpty(aoidAO.Text))
                        //{
                        //    s = s + "АО Проживания матери<br> ";
                        //}
                        //else
                        //{
                        cmd.Parameters.AddWithValue("@AoidAO", aoidAO.Text);//место проживания
                        //}
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@AoidAO", "");//место проживания
                    }
                    //ИЗМЕНЕНО НА ТЕКСТОВЫЕ ПОЛЯ
                    if (string.IsNullOrEmpty(txfStreetLife.Text))
                    {
                        cmd.Parameters.AddWithValue("@LifeStreet", null);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@LifeStreet", txfStreetLife.Text);
                    }
                    if (string.IsNullOrEmpty(txfHouseLife.Text))
                    {
                        cmd.Parameters.AddWithValue("@LifeHouse", null);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@LifeHouse", txfHouseLife.Text);
                    }
                    if (string.IsNullOrEmpty(nbfRoomLife.Text))
                    {
                        cmd.Parameters.AddWithValue("@LifeRoom", null);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@LifeRoom", nbfRoomLife.Text);
                    }
                }
                //cmd.Parameters.AddWithValue("@AoidHouseLife", aoidHouseLife.Text);
                //МЕСТНОСТЬ ПРОЖИВАНИЯ МАТЕРИ
                if (LocationLife_1.Checked)//если выбрана городская
                {
                    cmd.Parameters.AddWithValue("@LocationLife", 1);//записывается  1
                }
                if (LocationLife_2.Checked)//если выбрана сельская
                {
                    cmd.Parameters.AddWithValue("@LocationLife", 2);//записывается 2
                }
                if (LocationLife_3.Checked)//если выбрана неизвестно
                {
                    cmd.Parameters.AddWithValue("@LocationLife", 3);//записывается 2
                }
                //if (!LocationLife_1.Checked && !LocationLife_2.Checked && !LocationLife_3.Checked)
                //{
                //    s = s + "Местность проживания матери<br>";
                //}

                //ДАННЫЕ О СВИДЕТЕЛЬСТВЕ
                //СЕРИЯ СВИДЕТЕЛЬСТВА
                if (string.IsNullOrEmpty(SerialSv.Text))
                {
                    s = s + "Серия свидетельства<br> ";
                    SerialSv.MarkInvalid();
                }
                else
                {
                    cmd.Parameters.AddWithValue("@SerialSv", SerialSv.Text);//серия свидетельства
                }
                //НОМЕР СВИДЕТЕЛЬСТВА
                if (string.IsNullOrEmpty(NumberSv.Text))
                {
                    s = s + "Номер свидетельства<br> ";
                    NumberSv.MarkInvalid();
                }
                else
                {
                    cmd.Parameters.AddWithValue("@NumberSv", NumberSv.Text);//серия свидетельства
                }
                //ДАТА СВИДЕТЕЛЬСТВА
                if (DateSv.Text == "01.01.0001 0:00:00")
                {
                    s = s + "Дата свидетельства<br> ";
                    DateSv.MarkInvalid();
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DateIssueSv", DateSv.Text);//ДАТА СВИДЕТЕЛЬСТВА
                }
                //ВИД СВИДЕТЕЛЬСТВА


                cmd.Parameters.AddWithValue("@id_Doctor", Convert.ToInt32(id_Doctor.Text));//заполнение id доктора
                
               
                //РОДЫ ПРОИЗОШЛИ
                if (BirthOccurred_1.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_BirthOccurred", 1);
                    cmd.Parameters.AddWithValue("@id_BirthOccurredLpu", BirthOccurred_LPU.Value);
                }
                if (BirthOccurred_2.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_BirthOccurred", 2);
                    cmd.Parameters.AddWithValue("@id_BirthOccurredLpu", null);
                }
                if (BirthOccurred_3.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_BirthOccurred", 3);
                    cmd.Parameters.AddWithValue("@id_BirthOccurredLpu", null);
                }
                if (BirthOccurred_4.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_BirthOccurred", 4);
                    cmd.Parameters.AddWithValue("@id_BirthOccurredLpu", null);
                }

                if (chbStillBirth_1.Checked)
                {
                    cmd.Parameters.AddWithValue("@NumberBirth", null);
                    cmd.Parameters.AddWithValue("@AllBirth", null);
                    cmd.Parameters.AddWithValue("@id_VidBirth", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@NumberBirth", Convert.ToInt32(nbfStillBirth_2.Text));
                    cmd.Parameters.AddWithValue("@AllBirth", Convert.ToInt32(nbfStillBirth_3.Text));
                    cmd.Parameters.AddWithValue("@id_VidBirth", 1);
                }

                //ФАМИЛИЯ, ИМЯ, ОТЧЕСТВО ПОЛУЧАТЕЛЯ
                cmd.Parameters.AddWithValue("@RecipientFamily", txfRecipientFamily.Text);
                cmd.Parameters.AddWithValue("@RecipientName", txfRecipientName.Text);
                cmd.Parameters.AddWithValue("@RecipientFatherName", txfRecipientFatherName.Text);
                //ОТНОШЕНИЕ К УМЕРШЕМУ
                cmd.Parameters.AddWithValue("@RecipientRatio", txfRecipientRatio.Text);
                //СЕРИЯ И НОМЕР ПОЛУЧАТЕЛЯ
                if (string.IsNullOrEmpty(txfRecipientDocSerial.Text))
                {
                    cmd.Parameters.AddWithValue("@RecipientDocSerial", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@RecipientDocSerial", txfRecipientDocSerial.Text);
                }
                if (string.IsNullOrEmpty(txfRecipientDocNumber.Text))
                {
                    cmd.Parameters.AddWithValue("@RecipientDocNumber", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@RecipientDocNumber", txfRecipientDocNumber.Text);
                }
                //КЕМ ВЫДАН ДОКУМЕНТ ПОЛУЧАТЕЛЮ
                cmd.Parameters.AddWithValue("@RecipientDocWho", txfRecipientDocWho.Text);
                cmd.Parameters.AddWithValue("@RecipientDocPol", txfRecipientDocPol.Text);
                //ДАТА ПОЛУЧЕНИЯ СВИДЕТЕЛЬСТВА ПОЛУЧАТЕЛЕМ
                
                //СЕМЕЙНОЕ ПОЛОЖЕНИЕ МАТЕРИ
                if (MaritalStatus_1.Checked)//семейное положение 1
                {
                    cmd.Parameters.AddWithValue("@id_MaritalStatus", 1);//записывается  1
                }
                if (MaritalStatus_2.Checked)//семейное положение 2
                {
                    cmd.Parameters.AddWithValue("@id_MaritalStatus", 2);//записывается 2
                }
                if (MaritalStatus_3.Checked)//семейное положение 3
                {
                    cmd.Parameters.AddWithValue("@id_MaritalStatus", 3);//записывается 3
                }
                if (!MaritalStatus_1.Checked && !MaritalStatus_2.Checked && !MaritalStatus_3.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_MaritalStatus", null);
                }
                //ОБРАЗОВАНИЕ МАТЕРИ
                if (rEducation_1.Checked)//выбрано профессиональное образовние
                {
                    if (cmbEducation_1.Text == "")//если пустое проффессионаяльное то
                    {

                        cmd.Parameters.AddWithValue("@id_Education", null);//образование пустое
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@id_Education", Convert.ToInt32(cmbEducation_1.SelectedItem.Value.ToString()));//образование заполнятеся значением
                    }
                }
                if (rEducation_2.Checked)//выбрано общее то
                {
                    if (cmbEducation_2.Text == "")//если пустое общее то
                    {

                        cmd.Parameters.AddWithValue("@id_Education", null);//образование пустое
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@id_Education", Convert.ToInt32(cmbEducation_2.SelectedItem.Value.ToString()));//образование заполнятеся значением
                    }
                }
                if (rEducation_3.Checked)//если выбрано неизвестно то
                {
                    cmd.Parameters.AddWithValue("@id_Education", 8);//записывается  8
                }
                if (!rEducation_1.Checked && !rEducation_2.Checked && !rEducation_3.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_Education", null);
                }

                //ЗАНЯТОСТЬ МАТЕРИ
                if (rWork_1.Checked)//выбрано был(а) занат(а) в экономике образовние
                {
                    if (cmbWork_1.Text == "")//если пустое был(а) занат(а) в экономике то
                    {

                        cmd.Parameters.AddWithValue("@id_Job", null);//занятость пустое
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@id_Job", Convert.ToInt32(cmbWork_1.SelectedItem.Value.ToString()));//Занятость заполнятеся значением
                    }
                }
                if (rWork_2.Checked)//выбрано не был(а) занят(а) в экономике то
                {
                    if (cmbWork_2.Text == "")//если пустое не был(а) занят(а) в экономике то
                    {

                        cmd.Parameters.AddWithValue("@id_Job", null);//занятость пустое
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@id_Job", Convert.ToInt32(cmbWork_2.SelectedItem.Value.ToString()));//занятость заполнятеся значением
                    }
                }
                if (rWork_3.Checked)//если выбрано прочие то
                {
                    cmd.Parameters.AddWithValue("@id_Job", 5);//записывается  5
                }
                if (!rWork_1.Checked && !rWork_2.Checked && !rWork_3.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_Job", null);
                }

                cmd.Parameters.AddWithValue("@GoWeek", nbfGoWeek.Text);
                cmd.Parameters.AddWithValue("@NumberKidFromMother", nbfNumberChield.Text);
                
               
                //ЛИЦО ПРИНИМАВШЕЕ РОДЫ
                if (FaceTakeBirth_1.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_FaceTakeBirth", 1);
                }
                if (FaceTakeBirth_2.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_FaceTakeBirth", 2);
                }
                if (FaceTakeBirth_3.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_FaceTakeBirth", 3);
                }
                if (!FaceTakeBirth_1.Checked && !FaceTakeBirth_2.Checked && !FaceTakeBirth_3.Checked)
                {
                    cmd.Parameters.AddWithValue("@id_FaceTakeBirth", null);
                }


                //СНИЛС
                if (string.IsNullOrEmpty(SnilsTxt.Text))
                {
                    cmd.Parameters.AddWithValue("@SS", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@SS", SnilsTxt.Text);
                }
                

                //ПОЛИС ОМС
                if (string.IsNullOrEmpty(SnilsTxt.Text))
                {
                    cmd.Parameters.AddWithValue("@Polis", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Polis", PolisTxt.Text);
                }
                

                //Документ удостоверяющий личность
                if (string.IsNullOrEmpty(SnilsTxt.Text))
                {
                    cmd.Parameters.AddWithValue("@DocType", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DocType", TypeDocument.Text);
                }
                if (string.IsNullOrEmpty(SnilsTxt.Text))
                {
                    cmd.Parameters.AddWithValue("@DocSerial", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DocSerial", SerialDocum.Text);
                }
                if (string.IsNullOrEmpty(SnilsTxt.Text))
                {
                    cmd.Parameters.AddWithValue("@DocNumber", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DocNumber", NumberDocum.Text);
                }
                if (string.IsNullOrEmpty(SnilsTxt.Text))
                {
                    cmd.Parameters.AddWithValue("@DocNumber", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DocWhoIssue", DocWho.Text);
                }
                



                //СТАТУС СВИДЕТЕЛЬСТВА
                cmd.Parameters.AddWithValue("@id_Status", 1);

                
                
                //ЗАКРЫТИЕ ЗАПРОСА
                cmd.ExecuteNonQuery();
                Conn.Close();
                metka = 1;

            }
            catch (Exception err)
            {
                X.Msg.Alert("Внимание", "Произошла ошибка, данные не были занесены в базу." + string.Format(s).ToString()+err.Message).Show();
            }
            if (metka == 1)
            {
                X.Msg.Alert("Внимание", "Данные были успешно занесены в базу и в форму для печати. Теперь вы можете печатать свидетельство").Show();
                btnSaveExtract.Disabled = true;
                btnPrint_1.Disabled = false;
                btnPrint_2.Disabled = false;
            }
        }

        protected void ifAlien_check(object sender, DirectEventArgs e)
        {
            if (ifAlien.Checked)
            {
                AlienGroup.Hidden = false;
                fcMotherLifePlace.Hidden = true;
                //PlaceBirthFull.Hidden = true;
            }
            else
            {
                fcMotherLifePlace.Hidden = false;
                //PlaceBirthFull.Hidden = false;
                AlienGroup.Hidden = true;
            }
        }

        //Кнопка печати страницы 1
        protected void btnPrint_1_Click(object sender, DirectEventArgs e)
        {
            Parser templRCPT = new Parser();
            templRCPT.OpenTemplate(String.Format("{0}themplates/103p1.html", AppDomain.CurrentDomain.BaseDirectory));



            //ЗАПОЛНЕНИЕ ПЕЧАТНОЙ ФОРМЫ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            //Ф ребёнка           
            templRCPT.SetVariable("FIO", " " + txfKidFamily.Text);
            //ФИО умершего-
            //ФИО МАТЕРИ
            templRCPT.SetVariable("FIOM", " " + txfMotherFamily.Text + " " + txfMotherName.Text + " " + txfMotherFatherName.Text);
            templRCPT.SetVariable("FIOM1", " " + txfMotherFamily.Text);
            templRCPT.SetVariable("FIOM2", " " + txfMotherName.Text + " " + txfMotherFatherName.Text);
            /////////

            //ДАТА РОЖДЕНИЯ МАТЕРИ
            templRCPT.SetVariable("DRM", MotherBirthDay.SelectedDate.ToString("yyyy-MM-dd"));//ДАТА РОЖДЕНИЯ МАТЕРИ
            /////////////////


            ////Дата свидетельства
            if (DateSv.Text == "01.01.0001 0:00:00")
            {
                templRCPT.SetVariable("PdateSv", "");
            }
            else
            {
                templRCPT.SetVariable("PdateSv", DateSv.SelectedDate.ToString("yyyy-MM-dd"));
            }

            //Номер свидетельства
                if (string.IsNullOrEmpty(NumberSv.Text))
                {
                    templRCPT.SetVariable("NumberSv", "");
                }
                else
                {
                    templRCPT.SetVariable("NumberSv", NumberSv.Text);
                }

            //-ДАТА Свидетельства конец
            
            //Дата свидетельста-
            //birthday
            //Дата рождения
            if (cmbBirth.Value.ToString() == "FullDate")
            {
                templRCPT.SetVariable("DR3", dfFullDate.SelectedDate.ToString("yyyy-MM-dd"));
                templRCPT.SetVariable("DR3g", "GGGG");
            }
            if (cmbBirth.Value.ToString() == "YearDate")
            {
                templRCPT.SetVariable("DR3g", nbfYearDate.Text);
                templRCPT.SetVariable("dr3m2", "XX");
                templRCPT.SetVariable("DR3m", "XX");
                templRCPT.SetVariable("DR3d", "XX");
            }
            if (cmbBirth.Value.ToString() == "YaMDate")
            {
                templRCPT.SetVariable("DR3g", nbfYearDate.Text);
                templRCPT.SetVariable("dr3m2", "XX");
                templRCPT.SetVariable("DR3m", cmbMonthDate.Value.ToString());
                templRCPT.SetVariable("DR3d", "XX");
            }
            if (cmbBirth.Value.ToString() == "NoDate")
            {
                templRCPT.SetVariable("DR3g", "XXXX");
                templRCPT.SetVariable("dr3m2", "XX");
                templRCPT.SetVariable("DR3m", "XX");
                templRCPT.SetVariable("DR3d", "XX");
            }
            if (TimeBirth.Text == "")
            {
                templRCPT.SetVariable("TIME1", "-");
                templRCPT.SetVariable("TIME2", "-");
            }
            else
            {
                templRCPT.SetVariable("TIME1", string.Format(TimeBirth.Text).Substring(0,2));
                templRCPT.SetVariable("TIME2", string.Format(TimeBirth.Text).Substring(3, 2));
            }

            //Адрес проживания матери 1

            if (ifAlien.Checked)
            {
                //Адрес проживания иностранца 1
                if (string.IsNullOrEmpty(txfRegionAlien.Text))
                {
                    templRCPT.SetVariable("oblLife", "");
                }
                else
                {
                    templRCPT.SetVariable("oblLife", txfRegionAlien.Text);
                }
                if (string.IsNullOrEmpty(txfAreaAlien.Text))
                {
                    templRCPT.SetVariable("rayLife", "");
                }
                else
                {
                    templRCPT.SetVariable("rayLife", txfAreaAlien.Text);
                }
                if (string.IsNullOrEmpty(txfCityAlien.Text))
                {
                    templRCPT.SetVariable("gorLife", "");
                }
                else
                {
                    templRCPT.SetVariable("gorLife", txfCityAlien.Text);
                }
                if (string.IsNullOrEmpty(txfTownAlien.Text))
                {
                    templRCPT.SetVariable("nasLife", "");
                }
                else
                {
                    templRCPT.SetVariable("nasLife", txfTownAlien.Text);
                }

                if (string.IsNullOrEmpty(txfStreetAlien.Text))//изменено на текстовое поле
                {
                    templRCPT.SetVariable("strLife", "");
                }
                else
                {
                    templRCPT.SetVariable("strLife", txfStreetAlien.Text);
                }
                if (string.IsNullOrEmpty(txfHouseAlien.Text))//изменено на текстовое поле
                {
                    templRCPT.SetVariable("homeLife", "");
                }
                else
                {
                    templRCPT.SetVariable("homeLife", txfHouseAlien.Text);
                }
                if (string.IsNullOrEmpty(txfRoomAlien.Text))
                {
                    templRCPT.SetVariable("roomLife", "");
                }
                else
                {
                    templRCPT.SetVariable("roomLife", txfRoomAlien.Text);
                }
                templRCPT.SetVariable("roomLife", txfRoomAlien.Text);
            }
            else
            {

                if (string.IsNullOrEmpty(cmbRegionLife.Text))
                {
                    templRCPT.SetVariable("oblLife", "");
                }
                else
                {
                    templRCPT.SetVariable("oblLife", "РФ, " + cmbRegionLife.SelectedItem.Text);
                }

                if (string.IsNullOrEmpty(cmbAreaLife.Text))
                {
                    if (string.IsNullOrEmpty(cmbAO.Text))
                    {
                        templRCPT.SetVariable("rayLife", " ");
                    }
                    else
                    {
                        templRCPT.SetVariable("rayLife", cmbAO.SelectedItem.Text.Substring(4));
                    }
                }
                else
                {
                    templRCPT.SetVariable("rayLife", cmbAreaLife.SelectedItem.Text.Substring(4));
                }
                if (string.IsNullOrEmpty(cmbCityLife.Text))
                {
                    templRCPT.SetVariable("gorLife", "");
                }
                else
                {
                    templRCPT.SetVariable("gorLife", cmbCityLife.SelectedItem.Text);
                }
                if (string.IsNullOrEmpty(cmbTownLife.Text))
                {
                    templRCPT.SetVariable("nasLife", "");
                }
                else
                {
                    List<Dictionary<string, string>> rec = JSON.Deserialize<List<Dictionary<string, string>>>(e.ExtraParams["cmbTown"]);
                    foreach (Dictionary<string, string> one in rec)
                    {
                        if (one["AOID"] == cmbTownLife.SelectedItem.Value)
                        {
                            templRCPT.SetVariable("nasLife", string.Format("{0} {1}", one["ShortName"], one["FormalName"]));
                        }
                    }
                    //templRCPT.SetVariable("nasLife", cmbTownLife.SelectedItem.Text);
                }
                if (string.IsNullOrEmpty(txfStreetLife.Text))
                {
                    templRCPT.SetVariable("strLife", "");
                }
                else
                {
                    templRCPT.SetVariable("strLife", txfStreetLife.Text);
                }
                if (string.IsNullOrEmpty(txfHouseLife.Text))
                {
                    templRCPT.SetVariable("homeLife", "");
                }
                else
                {
                    templRCPT.SetVariable("homeLife", txfHouseLife.Text);
                }
                if (string.IsNullOrEmpty(nbfRoomLife.Text))
                {
                    templRCPT.SetVariable("roomLife", "");
                }
                else
                {
                    templRCPT.SetVariable("roomLife", nbfRoomLife.Text);
                }
            }

            //Адрес проживания матери-

            //Адрес рождения
            if (string.IsNullOrEmpty(cmbRegionBirth.Text))
            {
                templRCPT.SetVariable("oblBirth", "");
            }
            else
            {
                templRCPT.SetVariable("oblBirth", "РФ, " + cmbRegionBirth.SelectedItem.Text);
            }
            if (string.IsNullOrEmpty(cmbAreaBirth.Text))
            {
                if (string.IsNullOrEmpty(cmbBirthAO.Text))
                {
                    templRCPT.SetVariable("rayBirth", " ");
                }
                else
                {
                    templRCPT.SetVariable("rayBirth", cmbBirthAO.SelectedItem.Text.Substring(4));
                }
                //templRCPT.SetVariable("rayBirth", "");
            }
            else
            {
                templRCPT.SetVariable("rayBirth", cmbAreaBirth.SelectedItem.Text.Substring(4));
            }
            if (string.IsNullOrEmpty(cmbCityBirth.Text))
            {
                templRCPT.SetVariable("gorBirth", "");
            }
            else
            {
                templRCPT.SetVariable("gorBirth", cmbCityBirth.SelectedItem.Text);
            }
            if (string.IsNullOrEmpty(cmbTownBirth.Text))
            {
                templRCPT.SetVariable("nasBirth", "");
            }
            else
            {
                List<Dictionary<string, string>> rec = JSON.Deserialize<List<Dictionary<string, string>>>(e.ExtraParams["cmbTown2"]);
                foreach (Dictionary<string, string> one in rec)
                {
                    if (one["AOID"] == cmbTownBirth.SelectedItem.Value)
                    {
                        templRCPT.SetVariable("nasBirth", string.Format("{0} {1}", one["ShortName"], one["FormalName"]));
                    }
                }
                //templRCPT.SetVariable("nasBirth", cmbTownBirth.SelectedItem.Text);
            }
            ////////////////////////////////////////////////////////
            
            //ПОЛ
            templRCPT.SetVariable("Sex", "");
            if (SexMale.Checked)
            {
                templRCPT.SetVariable("Sex", "1");
            }
            if (SexFemale.Checked)
            {
                templRCPT.SetVariable("Sex", "2");
            }
           
            //Местность
            templRCPT.SetVariable("LocD", "");
            templRCPT.SetVariable("LocL", "");

            if (LocationBirth_1.Checked)
            {
                templRCPT.SetVariable("LocD", "1");
            }
            if (LocationBirth_2.Checked)
            {
                templRCPT.SetVariable("LocD", "2");
            }
            if (LocationLife_1.Checked)
            {
                templRCPT.SetVariable("LocL", "1");
            }
            if (LocationLife_2.Checked)
            {
                templRCPT.SetVariable("LocL", "2");
            }
            //Местность-
        
           
            //8 пункт
            templRCPT.SetVariable("PSP", "");
            if (MaritalStatus_1.Checked)
            {
                templRCPT.SetVariable("PSP", "1");
            }
            if (MaritalStatus_2.Checked)
            {
                templRCPT.SetVariable("PSP", "2");
            }
            if (MaritalStatus_3.Checked)
            {
                templRCPT.SetVariable("PSP", "3");
            }
            //8 пункт-

            templRCPT.SetVariable("BirthWas", "");

            if (BirthOccurred_1.Checked)
            {
                templRCPT.SetVariable("BirthWas", "1");
            }
            if (BirthOccurred_2.Checked)
            {
                templRCPT.SetVariable("BirthWas", "2");
            }
            if (BirthOccurred_3.Checked)
            {
                templRCPT.SetVariable("BirthWas", "3");
            }
            if (BirthOccurred_4.Checked)
            {
                templRCPT.SetVariable("BirthWas", "4");
            }

            //СНИЛС
            if (string.IsNullOrEmpty(SnilsTxt.Text))
            {
                templRCPT.SetVariable("SS", "");
            }
            else
            {
                templRCPT.SetVariable("SS", SnilsTxt.Text);
            }
            

            //ПОЛИС ОМС
            if (string.IsNullOrEmpty(PolisTxt.Text))
            {
                templRCPT.SetVariable("Polis", "");
            }
            else
            {
                templRCPT.SetVariable("Polis", PolisTxt.Text);
            }
      

            //Документ удостоверяющий личность
            if (string.IsNullOrEmpty(TypeDocument.Text))
            {
                templRCPT.SetVariable("DocType", TypeDocument.Text);
            }
            else
            {
                templRCPT.SetVariable("DocType", TypeDocument.Text);
            }
            if (string.IsNullOrEmpty(SerialDocum.Text))
            {
                templRCPT.SetVariable("DocSerial", SerialDocum.Text);
            }
            else
            {
                templRCPT.SetVariable("DocSerial", SerialDocum.Text);
            }
            if (string.IsNullOrEmpty(NumberDocum.Text))
            {
                templRCPT.SetVariable("DocNumber", NumberDocum.Text);
            }
            else
            {
                templRCPT.SetVariable("DocNumber", NumberDocum.Text);
            }
            if (string.IsNullOrEmpty(DocWho.Text))
            {
                templRCPT.SetVariable("DocWhoIssue", DocWho.Text);
            }
            else
            {
                templRCPT.SetVariable("DocWhoIssue", DocWho.Text);
            }
           

            //Образование
            templRCPT.SetVariable("PAD", "");
            if (rEducation_1.Checked)
            {
                if (cmbEducation_1.SelectedItem.Value == "1")
                {
                    templRCPT.SetVariable("PAD", "1");
                }
                if (cmbEducation_1.SelectedItem.Value == "2")
                {
                    templRCPT.SetVariable("PAD", "2");
                }
                if (cmbEducation_1.SelectedItem.Value == "3")
                {
                    templRCPT.SetVariable("PAD", "3");
                }
             
            }
            if (rEducation_2.Checked)
            {
                if (cmbEducation_2.SelectedItem.Value == "4")
                {
                    templRCPT.SetVariable("PAD", "4");
                }
                if (cmbEducation_2.SelectedItem.Value == "5")
                {
                    templRCPT.SetVariable("PAD", "5");
                }
                if (cmbEducation_2.SelectedItem.Value == "6")
                {
                    templRCPT.SetVariable("PAD", "6");
                }
                if (cmbEducation_2.SelectedItem.Value == "7")
                {
                    templRCPT.SetVariable("PAD", "7");
                }
            }
            if (rEducation_3.Checked)
            {
                templRCPT.SetVariable("PAD", "8");
            }

            //Занятость
            templRCPT.SetVariable("PJOB", "");
            if (rWork_1.Checked)
            {
                if (cmbWork_1.SelectedItem.Value == "1")
                {
                    templRCPT.SetVariable("PJOB", "1");
                }
                if (cmbWork_1.SelectedItem.Value == "2")
                {
                    templRCPT.SetVariable("PJOB", "2");
                }
               
           
            }
            if (rWork_2.Checked)
            {
                if (cmbWork_2.SelectedItem.Value == "3")
                {
                    templRCPT.SetVariable("PJOB", "3");
                }
                if (cmbWork_2.SelectedItem.Value == "4")
                {
                    templRCPT.SetVariable("PJOB", "4");
                }
               
            }
            if (rWork_3.Checked)
            {
                templRCPT.SetVariable("PJOB", "5");
            }

            //ВЕС РЕБЁНКА(ПЛОДА)
            if (string.IsNullOrEmpty(nbfWeightKid.Value.ToString()))
            {
                templRCPT.SetVariable("KW", "");
            }
            else
            {
                templRCPT.SetVariable("KW", Convert.ToInt32(nbfWeightKid.Value.ToString()));
            }
            //ДЛИНА ТЕЛА РЕБЁНКА(ПЛОДА)
            if (string.IsNullOrEmpty(nbfLengthKid.Value.ToString()))
            {
                templRCPT.SetVariable("KL", "");
            }
            else
            {
                templRCPT.SetVariable("KL", Convert.ToInt32(nbfLengthKid.Value.ToString()));
            }

            //Которым по счету ребенок
            if (string.IsNullOrEmpty(nbfNumberChield.Text))
            {
                templRCPT.SetVariable("NB", "");
            }
            else
            {
                templRCPT.SetVariable("NB", Convert.ToInt32(nbfNumberChield.Text));
            }
            //Срок первой явки
            if (string.IsNullOrEmpty(nbfGoWeek.Text))
            {
                templRCPT.SetVariable("GW", "");
            }
            else
            {
                templRCPT.SetVariable("GW", Convert.ToInt32(nbfGoWeek.Text));
            }
           //
            if (chbStillBirth_1.Checked)
            {
                templRCPT.SetVariable("StillBirth_1", "X");
                templRCPT.SetVariable("StillBirth_2", " ");
                templRCPT.SetVariable("StillBirth_3", " ");
            }
            else
            {
                templRCPT.SetVariable("StillBirth_1", " ");
                templRCPT.SetVariable("StillBirth_2", Convert.ToInt32(nbfStillBirth_2.Text));
                templRCPT.SetVariable("StillBirth_3", Convert.ToInt32(nbfStillBirth_3.Text));
            }



            //////////////////////////


            string html = templRCPT.ParseToString();
            string js = "function printRecept(tx){win = window.open();win.document.write(tx);win.document.close();}";
            X.Js.AddScript(js);
            X.Js.Call("printRecept", html);
        }

        protected void btnPrint_2_Click(object sender, DirectEventArgs e)
        {
            Parser templRCPT = new Parser();
            templRCPT.OpenTemplate(String.Format("{0}themplates/103p2.html", AppDomain.CurrentDomain.BaseDirectory));

            templRCPT.SetVariable("BirthWas", "");

            if (BirthOccurred_1.Checked)
            {
                templRCPT.SetVariable("BirthWas", "1");
            }
            if (BirthOccurred_2.Checked)
            {
                templRCPT.SetVariable("BirthWas", "2");
            }
            if (BirthOccurred_3.Checked)
            {
                templRCPT.SetVariable("BirthWas", "3");
            }
            if (BirthOccurred_4.Checked)
            {
                templRCPT.SetVariable("BirthWas", "4");
            }


            if (string.IsNullOrEmpty(txfRecipientDocSerial.Text) || string.IsNullOrEmpty(txfRecipientDocNumber.Text) || string.IsNullOrEmpty(txfRecipientDocWho.Text))
            {
                templRCPT.SetVariable("PRecipientDocData", "");
            }
            else
            {
                templRCPT.SetVariable("PRecipientDocData", txfRecipientDocSerial.Text + " " + txfRecipientDocNumber.Text + " " + txfRecipientDocWho.Text);
            }
            if (string.IsNullOrEmpty(txfRecipientFamily.Text) || string.IsNullOrEmpty(txfRecipientName.Text))
            {
                templRCPT.SetVariable("PRecipientFIO", "");
            }
            else
            {
                templRCPT.SetVariable("PRecipientFIO", txfRecipientFamily.Text + " " + txfRecipientName.Text + " " + txfRecipientFatherName.Text + " " + txfRecipientRatio.Text);
            }

            if (string.IsNullOrEmpty(txfRecipientDocPol.Text))
            {
                templRCPT.SetVariable("PRecipientDocPol", "");
            }
            else
            {
                templRCPT.SetVariable("PRecipientDocPol", txfRecipientDocPol.Text);
            }

            
            //13 пункт-

            //14 пункт


            if (string.IsNullOrEmpty(nbfNumberChield.Text))
            {
                templRCPT.SetVariable("NB", "");
            }
            else
            {
                templRCPT.SetVariable("NB", Convert.ToInt32(nbfNumberChield.Text));
            }
            if (string.IsNullOrEmpty(nbfGoWeek.Text))
            {
                templRCPT.SetVariable("GW", "");
            }
            else
            {
                templRCPT.SetVariable("GW", Convert.ToInt32(nbfGoWeek.Text));
            }



            //14 пункт-
            ////////////////////////////////////

            templRCPT.SetVariable("FIO_Doctor", FIO_Doctor.Text);
            //13, 22, 18 пункт-
            templRCPT.SetVariable("Post_Doctor", Post_Doctor.Text);



          
            //if (string.IsNullOrEmpty(nbfStillBirth_2.Text))
            //{
            //    templRCPT.SetVariable("StillBirth_2", "");
            //}
            //else
            //{
            //    templRCPT.SetVariable("StillBirth_2", Convert.ToInt32(nbfStillBirth_2.Text));
            //}
            //if (string.IsNullOrEmpty(nbfStillBirth_3.Text))
            //{
            //    templRCPT.SetVariable("StillBirth_3", "");
            //}
            //else
            //{
            //    templRCPT.SetVariable("StillBirth_3", Convert.ToInt32(nbfStillBirth_3.Text));
            //}


            
            //ЛИЦО ПРИНИМАВШЕЕ РОДЫ
            if (FaceTakeBirth_1.Checked)
            {
                templRCPT.SetVariable("FaceTakeBirth", 1);
            }
            if (FaceTakeBirth_2.Checked)
            {
                templRCPT.SetVariable("FaceTakeBirth", 2);
            }
            if (FaceTakeBirth_3.Checked)
            {
                templRCPT.SetVariable("FaceTakeBirth", 3);
            }
            if (!FaceTakeBirth_1.Checked && !FaceTakeBirth_2.Checked && !FaceTakeBirth_3.Checked)
            {
                templRCPT.SetVariable("FaceTakeBirth", "");
            }
            templRCPT.SetVariable("Header", " " + txfHead_1.Text + " " + txfHead_2.Text + " " + txfHead_3.Text);


            string html = templRCPT.ParseToString();
            string js = "function printRecept(tx){win = window.open();win.document.write(tx);win.document.close();}";
            X.Js.AddScript(js);
            X.Js.Call("printRecept", html);

        }

    }
}