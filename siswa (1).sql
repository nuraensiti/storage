-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Agu 2024 pada 09.44
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siswa`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSiswaByBorn` (IN `tempatLahir` VARCHAR(255))   BEGIN
    SELECT * FROM datasiswa
    WHERE tempat_lahir = tempatLahir;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isiNilaiSiswa` (IN `p_nis` INT, IN `p_nilai_IPA` INT, IN `p_nilai_IPS` INT, IN `p_nilai_MATEMATIKA` INT)   BEGIN
    INSERT INTO nilaisiswa (nis, nilai_IPA, nilai_IPS, nilai_MATEMATIKA)
    VALUES (p_nis, p_nilai_IPA, p_nilai_IPS, p_nilai_MATEMATIKA);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validSiswa` (IN `p_nis` INT, IN `p_nilai_IPA` INT, IN `p_nilai_IPS` INT, IN `p_nilai_MATEMATIKA` INT)   BEGIN
    DECLARE exit handler FOR SQLEXCEPTION
    BEGIN
        -- Jika terjadi kesalahan, rollback transaksi
        ROLLBACK;
    END;

    -- Mulai transaksi
    START TRANSACTION;

    -- Coba melakukan insert ke tabel nilaisiswa
    INSERT INTO nilaisiswa (nis, nilai_IPA, nilai_IPS, nilai_MATEMATIKA)
    VALUES (p_nis, p_nilai_IPA, p_nilai_IPS, p_nilai_MATEMATIKA);

    -- Jika tidak terjadi kesalahan, commit transaksi
    COMMIT;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getJmlByGender` (`gender` CHAR(1)) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE jumlah INT;

    SELECT COUNT(*)
    INTO jumlah
    FROM datasiswa
    WHERE gender = gender;

    RETURN jumlah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `datasiswa`
--

CREATE TABLE `datasiswa` (
  `nis` int(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `tempat_lahir` varchar(333) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `gender` varchar(333) NOT NULL,
  `alamat` varchar(333) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `datasiswa`
--

INSERT INTO `datasiswa` (`nis`, `nama`, `tempat_lahir`, `tanggal_lahir`, `gender`, `alamat`) VALUES
(89120, 'Fahmi', 'Asahan', '1983-07-12', 'L', 'Jl.Medan 17'),
(89121, 'Toni', 'Bogor', '1980-01-25', 'L', 'Jl.Bogor 21'),
(89122, 'Mona', 'Jakarta', '1984-08-01', 'p', 'Jl.Danau Toba 34'),
(89123, 'Monika', 'Bandung', '1982-02-13', 'P', 'Jl. Samosir 39'),
(89124, 'Eno', 'Surabaya', '1984-04-01', 'P', 'Jl. Siantar 66'),
(89125, 'Fitri', 'Jakarta', '1983-08-01', 'P', 'Jl. Sei Rampah 45'),
(89126, 'Prima', 'Surabaya', '1985-06-12', 'P', 'Jl. Binjai 11'),
(89127, 'Hotdi', 'Bogor', '1983-09-01', 'P', 'Jl. Kartika'),
(89128, 'Yuni', 'Malang', '1984-10-18', 'P', 'Jl. Kisaran 56'),
(89129, 'Helni', 'Malang', '1985-11-21', 'P', 'Jl. Teladan');

--
-- Trigger `datasiswa`
--
DELIMITER $$
CREATE TRIGGER `before_siswa_delete` BEFORE DELETE ON `datasiswa` FOR EACH ROW BEGIN
    INSERT INTO SiswaKeluar (nis, tanggal_hapus)
    VALUES (OLD.nis, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilaisiswa`
--

CREATE TABLE `nilaisiswa` (
  `nis` int(11) NOT NULL,
  `nilai_IPA` int(11) NOT NULL,
  `nilai_IPS` int(11) NOT NULL,
  `nilai_MATEMATIKA` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `nilaisiswa`
--

INSERT INTO `nilaisiswa` (`nis`, `nilai_IPA`, `nilai_IPS`, `nilai_MATEMATIKA`) VALUES
(89122, 70, 60, 90),
(89123, 60, 60, 90),
(89124, 80, 50, 100),
(89125, 40, 60, 80),
(89126, 50, 65, 90),
(89127, 70, 80, 90),
(89128, 100, 60, 40),
(89122, 70, 60, 90),
(89122, 70, 60, 90),
(89122, 70, 60, 90),
(89130, 89, 90, 91),
(89122, 70, 60, 91),
(89131, 70, 90, 85),
(89122, 70, 60, 90),
(89122, 70, 60, 90),
(89122, 70, 60, 90),
(89122, 89, 60, 90),
(89122, 70, 60, 90);

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswakeluar`
--

CREATE TABLE `siswakeluar` (
  `nis` int(11) NOT NULL,
  `tanggal_hapus` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
